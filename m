Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013F3606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UF3e7pSo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 651F511217F;
	Thu, 19 Nov 2026 08:35:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A662B11217F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:35:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C730B611DA;
 Thu, 19 Nov 2026 08:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F3B1F000C4;
 Thu, 19 Nov 2026 08:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795077335;
 bh=61QgZFy6usqmGig6YbWvB0AGJ0RhMGQQzMdjEcOXkF8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UF3e7pSouUCkBmgUGWzXv6obRdWEKAwMHqFaJ72jaBa8Zd9B5tCGw/mPjCdz+6ReO
 +rdDb2XwfHZ06wRX9JQ4jDpu2/+/fdVMnwgGJ9Yl3VBx6HuC37zOQi2BVScETZB4Rx
 AkrymF1pHtDvqLvz/dYfzUiMPQCVZCXqDSEf+U2o47WzuApW33sn+byQdYO/yVEmnK
 +WrqgFoPmhS8rTFYQuSX4sJn6Jp0BiDfs6LF5oAXh5nuoaVKe79OtGODrQCikriEKe
 KaZBdTva+WJINo0NzrJnCEviUg1E77Qb/jTdX+buRqEAGcqPzpO1HUhxHLYgj2Jaw3
 xxMxf0zZ497lA==
Message-ID: <sashiko-outbox-222682@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 15/29] drm/msm/dpu: use stream_id to select MST
 interfaces
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-msm-dp-mst-v9-15-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
 <20261119-msm-dp-mst-v9-15-ca61be4edfc3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:35:34 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/msm/dpu: missing colon on @stream_id kernel-doc tag in
  msm_display_info
--

commit 1ac8db8a30bd58946d55f189ddce5112daaa02b5
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dpu: use stream_id to select MST interfaces

This commit adds a stream_id field to struct msm_display_info and uses it in
dpu_encoder_get_intf() to select the matching DPU interface for MST streams.

[Severity: Low]
In drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h (lines 31 and 39), the new
@stream_id kernel-doc tag on struct msm_display_info is missing a trailing
colon (@stream_id:). Without the colon, scripts/kernel-doc folds the line
into the preceding section and warns that struct member stream_id is not
described in msm_display_info.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-msm-dp-mst=
-v9-0-ca61be4edfc3@oss.qualcomm.com?part=3D15
