Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9399C606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7ouVFCP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F1A10E1D0;
	Tue, 10 Nov 2026 05:08:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8207910E1D0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:08:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 492EC6119D;
 Tue, 10 Nov 2026 05:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C3E1F0089F;
 Tue, 10 Nov 2026 05:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794287331;
 bh=HSMXqe7w0oauEuRxOWSxcEYOaq0MmU9J+nTyVdLgubg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q7ouVFCP2JkeuFotSefamHpW97QlrpinTr911Bb5sMqcp9S8dFL1LBnvjmmQxAEZE
 JCYmzIaSn0gltazRaqnnMAg/dFYz5dv2z+x4zmw7qsv6EHj0lEiE57KZGMxHjZmGZ0
 Ra2V85K5s/pc2gWORhz1JwJ93X66bwrUbbKm9wDmskLdngPdTHvk1NZw0qeQA0ZpRr
 7O5o5eMenemgkNErYTxr54Ua5cghAsh/qAY1lEWRHUJaXg1c2eoCBoipj26CJb/CFk
 +aP6wyVt0UxVK+4w9Tjabz0uPODS02PHGHzbBTu9V5CASG/3QNHxSFOhtnj0WV58xn
 /shVGHXH+Qukw==
Message-ID: <sashiko-outbox-206260@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/29] drm/msm/dpu: use stream_id to select MST
 interfaces
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-15-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-15-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:08:50 +0000
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

commit 0313df3cc2ee1271de0838612852764fd6f17739
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dpu: use stream_id to select MST interfaces

This commit adds a stream_id field to struct msm_display_info and uses it in
dpu_encoder_get_intf() to select the matching DPU interface for MST streams.

[Severity: Low]
In drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h, the kernel-doc entry added
for struct msm_display_info at line 31 is missing the trailing colon after
@stream_id (as well as @is_cmd_mode above it). Without @stream_id:,
scripts/kernel-doc treats the line as a continuation of the previous field
and warns that struct member stream_id is not described in msm_display_info.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D15
