Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C5BC531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8FA110E07A;
	Fri, 24 Jul 2026 21:52:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jj0CYan8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3420510E07A
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 21:52:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 35818600AD;
 Fri, 24 Jul 2026 21:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6421F000E9;
 Fri, 24 Jul 2026 21:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784929941;
 bh=uISh/u7ALVGrl6kfKRrfnLU5U/Mqe8+7Lnx6fMI7IPw=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=jj0CYan8BoR/CRXNJBaDlV4sIkyhISMfbjo8FnzwLapz02QWBAsjIJIxwJCgsGlKD
 /eJMM7HUYvJWZ16s5kor/IurXOuBOvj952jLGQIXgKgBUAuNybu4VfU8IB/CtzUEZF
 PIah1KyXS4rA31qxe5AfBfKQokWYkjyPCFhvFnJunye0KXqhPio26vb3wfdLUh5XjR
 M22yL3B65ih5aXFen6gYQycBO9d2AGY76J6NieyDwZNSF1H7wh8XtfX5TqZJ1OuBsS
 U5bzWNAPSzUUgPdf37OkHk3/8dTTzfgg+PmGo7DxG4Ub8TricUPfMSHZvWOTYic5i6
 DJ3n34qIttOeg==
From: Srinivas Kandagatla <srini@kernel.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Eddie Lin <eddie.lin@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260701-fastrpc-cctx-cleanup-v3-1-3a73c2e4ce1a@oss.qualcomm.com>
References: <20260701-fastrpc-cctx-cleanup-v3-1-3a73c2e4ce1a@oss.qualcomm.com>
Subject: Re: [PATCH v3] misc: fastrpc: fix memory leak in
 fastrpc_channel_ctx_free
Message-Id: <178492994036.533095.17096221699937376014.b4-ty@kernel.org>
Date: Fri, 24 Jul 2026 22:52:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


On Wed, 01 Jul 2026 19:21:59 -0700, Eddie Lin wrote:
> The 'ctx_idr' is initialized but never destroyed when
> the channel context is freed, leading to a memory leak.
> Add idr_destroy() to properly clean up the IDR resources.
> 
> 

Applied, thanks!

[1/1] misc: fastrpc: fix memory leak in fastrpc_channel_ctx_free
      commit: 7de6fc30fcf26d9096558ce41d58448fb5286f51

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

