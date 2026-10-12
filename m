Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23786CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A4810E585;
	Mon, 12 Oct 2026 13:16:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D14AB10F0F5
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:16:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F217660229;
 Mon, 12 Oct 2026 13:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528551F0089B;
 Mon, 12 Oct 2026 13:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791810991;
 bh=J/yQSMr0uJe1VjnFyZcvAFAq45+EbCCZdoO6Rk+QZW0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=USLTIu8Y5IsIfwzzjmhk0r/ZY0hkSga/trnJSFSVZC44YRjWVrBOnH+zNeTzWCINg
 rb2d6R5uvE/1HEmYoALENAkZ43CQ+6QAmy8UnN+gr9ov1t5FW/Y66Tplrc/Yk1aqpE
 NiUbbsEnAtbEth8zWzJMICY4OtYQhsgTuSQVBidC2WH/gRFXiwbwxb6Bl4aVZJfbbL
 lIzd8AMN9u+WfIZNvLayhKZ+zZULa7b/TrIi0l4x4UOlx0+8S7qfyVxA2PB6O+Xnpi
 ZpzsmZLBK9bf0/QPZdjjUNYy/7qwGgvobVTS5JshL+JCJB2FcHLMo2lNj/+JY/wR+P
 GLOrsZsqCeOKA==
Message-ID: <sashiko-outbox-168157@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 15/18] PCI/P2PDMA: Document TLP-class routing
To: "Leon Romanovsky" <leon@kernel.org>
Cc: kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 dri-devel@lists.freedesktop.org, media-ci@linuxtv.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-15-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-15-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:16:30 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> The P2PDMA documentation stated that the mapping result is not defined for
> Relaxed Ordering or ATS-translated Requests. It now is.
>=20
> Replace that paragraph with what the three TLP-sensitive ACS controls do
> and the table of outcomes per class.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D15

