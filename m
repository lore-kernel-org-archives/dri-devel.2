Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973E606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8B5TUmk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1833410E028;
	Thu,  5 Nov 2026 13:55:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D1810E028;
 Thu,  5 Nov 2026 13:55:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D644602C3;
 Thu,  5 Nov 2026 13:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9775A1F000C1;
 Thu,  5 Nov 2026 13:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793886945;
 bh=FRvCb0qdn0UFgCq8z99GAbGRLgJXO4j4sZWydl6Xwds=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=L8B5TUmkCR4s1r1wiNQSpXG2koNdEAW6KB+TqzDVo/Zb1Ew5F67tq4MoHL60J/a4d
 P1mzGlTZk78Ohq//u2YU359ZiciYbDIFCxJ8APqY6j4X1+ELfJvYEA0XAKiUZh9XIN
 KsOzC8VOUJuG92TnnENuZUUXAUS6zBXXtAzNxiZ6PzikDx0LxqXdWTatL7KdP+ob+z
 jwXhyQFGPr+lQSLfTzjTWdVPP+GPL1OuroIsxZuLLqAMK7zVbEB90pbErGwU1KU4UB
 /pfJvG7/H02SEG2FNqh5TF89cc9MyEvmGIay4WpWqDKsIgWkPckHt8aYC07f7x0D6N
 0DIcGyuEInHpw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 14:55:41 +0100
Message-Id: <DMNBUJVZHT7N.232EWW7QZINWD@kernel.org>
Subject: Re: [PATCH v2] dma-buf/sw_sync: Optimize the retrieval of fence
 reference counts
Cc: "Edward Adam Davis" <eadavis@sina.com>, <sashiko-bot@kernel.org>,
 <media-ci@linuxtv.org>, <sashiko-reviews@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
 <sumit.semwal@linaro.org>, <phasta@kernel.org>,
 <robin.clark@oss.qualcomm.com>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <sashiko-outbox-198550@kernel.org>
 <20261105052707.55911-1-eadavis@sina.com>
 <ad203438-ddbe-4445-bb3e-9632e738c1a5@amd.com>
In-Reply-To: <ad203438-ddbe-4445-bb3e-9632e738c1a5@amd.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 5, 2026 at 11:03 AM CET, Christian K=C3=B6nig wrote:
> On 11/5/26 06:27, Edward Adam Davis wrote:
>> Fixes: e531fdb5cd5e ("dma-buf/sw_sync: Avoid recursive lock during fence=
 signal")
>
> Please completely drop that. This is not something which has any justific=
ation to be backported.

Fixes: identifies the commit that introduced a bug for better reference,
independently of whether the fix should be backported.

If something shouldn't be selected by autosel one can add

	Cc: <stable+noautosel@kernel.org> # reason to exclude from stable

In this case I assume you said that because SW_SYNC is test infrastructure?=
 If
so, AFAIK the stable team explicitly does backport test infrastructure as p=
eople
also run selftests on stable kernels.

Thanks,
Danilo
