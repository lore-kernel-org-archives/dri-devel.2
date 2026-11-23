Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0757606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=AVmDqTm3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CEDE10E77D;
	Mon, 23 Nov 2026 09:48:13 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1090710E77D
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 09:48:06 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jY1Ml0MrfzKn2f;
 Mon, 23 Nov 2026 10:48:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1795427283; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gDqxUua/SVNz+vUi7hngGeTF67Hkrr8BY9nXOqW1A6Y=;
 b=AVmDqTm3VArUTJdoiJLZ4Z2Gyk8uUPTVdPM/lMXgNiJ2U/lwAzNNnLNlMHeG54WnYR9xE0
 EyUZZKO2jibClJ4IZxDQrpchMTNazfwT3kf64NqyHGUyPotbq4TKCVarz5OtxoZPXoXmoe
 RPA030SPv66QqlyfO14dyCgr2MJ8p8S6VZ9F0xvwJo8SRQMBZUzCfTegjXrlymENssG6QN
 mDx/efVKFJSxBDHDxB0183yqqvbYg/e0dtwtGzDzXNjn3MAclZfb9BgWw0uYSjvh8lQo1D
 2sVIRX1arE9rgfXS/68+xxuYOlGHI4NK7pOCXY8n56JG7iYyX/C07c1lOGZBNg==
Message-ID: <6fc8d8cbb05d00ce6ea35f8e3993d9ec96fee9da.camel@mailbox.org>
Subject: Re: [PATCH v2] dma-buf/dma-fence: Remove dma_fence_later()
From: Philipp Stanner <phasta@mailbox.org>
To: Philipp Stanner <phasta@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>,  Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 23 Nov 2026 10:48:01 +0100
In-Reply-To: <20261120112702.2970576-3-phasta@kernel.org>
References: <20261120112702.2970576-3-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: cc13eacd4bd05710574
X-MBO-RS-META: wke9cicegga7jcb4mfses1j14whsm1mf
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
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-11-20 at 12:27 +0100, Philipp Stanner wrote:
> dma_fence_later() does not have any in-tree users anymore.
> dma_fence_is_later() is available as an alternative.
>=20
> Remove the surplus function.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
> Changes in v2:
> =C2=A0 - Rebase onto misc-next due to conflict.
> =C2=A0 - Add Christian's Rb.

Applied to misc-next.

P.
