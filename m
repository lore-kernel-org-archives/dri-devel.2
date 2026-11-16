Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AF9606A336
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ml95Tpkh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B7D10E35E;
	Mon, 16 Nov 2026 13:57:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BEE810E4C8
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:57:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5558B464C6;
 Mon, 16 Nov 2026 13:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59961F000C4;
 Mon, 16 Nov 2026 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794837433;
 bh=QENVAfGaOo7cG1bvZbxpHS9yVMi7DsE5+E5r95kzd9U=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=ml95TpkhccdOdCRgqDBw8B/20phX6V6A1Xts98+iUqCBqyfrGl9bqmmewT7LZDLgB
 cNg/PJOeL3JnR2R55byH5qrj3ZptnSPxy4JQdqDzVVZg+m6fkBOUAMH9lRK1nALKJV
 AxJNo2XgUr6Z0vvRUMX8JAQ47s7okiQhWRpQfkynY+ckEa8lCu7C2h20mFBxjsYFKk
 jH2kXTbqCv0PDJWTovf2UJ2hN+TLAZXxZ641uUdD5lbprL4pDuYASJ3V2dlA5KonvJ
 eRS5afGshQcH8COdh7BY+pqoHZKyENZ7EraGDoT4FTd0ruLcJYH7pO6KX/rW8Yd8Q2
 Xgj0IYb/C3U2A==
From: Srinivas Kandagatla <srini@kernel.org>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thierry Escande <thierry.escande@linaro.org>, 
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>, 
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
References: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/2] fastrpc: fix probe-time races between rpmsg and
 userspace
Message-Id: <179483743046.37272.7082029810163966845.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 13:57:10 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Thu, 22 Oct 2026 14:38:46 +0530, Vinayak Katoch wrote:
> This series fixes two races in fastrpc_rpmsg_probe() that can be
> triggered when userspace opens a fastrpc device node concurrently with
> the rpmsg probe sequence.
> 
> fastrpc_device_register() calls misc_register() before the channel
> context is fully initialised. A concurrent open() in that window hits
> kref_get() on a zero refcount, and because fastrpc_cb_devices_create()
> has not yet run sesscount is 0, the error path calls kref_put() on the
> saturated refcount, triggering kfree() of the channel context. A
> subsequent IRQ-path fastrpc_rpmsg_callback() then dereferences the
> freed spinlock, causing a kernel panic. A NULL dereference in the
> fastrpc_device_open() error path when cctx->rpdev is concurrently
> cleared by fastrpc_rpmsg_remove() is also addressed.
> 
> [...]

Applied, thanks!

[1/2] misc: fastrpc: fix NULL rpdev dereference when session alloc fails
      commit: 2b22e3266386190d2027d9f12f317e0662a40711
[2/2] misc: fastrpc: fix init ordering race in rpmsg probe
      commit: 1bf78aac760fd25b684153f8c477aede9b9dd634

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

