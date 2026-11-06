Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D4606D802
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C5FbMcjH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cKo4RW/p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ACEC112D9C;
	Fri,  6 Nov 2026 13:44:47 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E6210E414
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:44:35 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6APNmP527482
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 13:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=rZtFwhZNNp3I4CxFlYMx4Z
 +4Hq02VTYQrKNwwmgilIY=; b=C5FbMcjH2kUti17e9wxnO6sIoJgyejo1a4AZXQ
 jqoXcLwUtibclt7aRakhxjOs3mquXNjn6p4q65One1N1HPYx031cEIre5KceMAVD
 TlM16LtZF2OonQUtPqHN0KPVsx6FCtK9sX6CM2cFZwxQUWp+CO2pg8YhN8Bl6VDz
 cygD7D1VWTgS+qX07U2Bfux5ZoX2vWc1xp8B0ObqMZhCtSpavo3TneePhsNaEuok
 NNs3Oco+FLYZt9Sc03SH+TwxZaZLJvo30CHgHf2n1Mzck4IRhLvwo/OvlYoK0kdg
 B0LgWoi3XT5EMy/SMj23PxwSAKDYL+UKUOujg30bEfVmSHoQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9u042-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 13:44:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb93c874bso350671385a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 05:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793972674; x=1794577474;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rZtFwhZNNp3I4CxFlYMx4Z+4Hq02VTYQrKNwwmgilIY=;
 b=cKo4RW/p03X8IdkgbRH20py4dtCstVMXS0NaUF4sgIH6/XRFjNikrs77+yyoPlB322
 QDdE1JOMkBr+D5QfZ0X11Vt3ILMa7pBJItCHOXbSlnHP076pzG3phfXxhO6L/20PGj1P
 Pb5r87Nym04bh9EB0p1c4xqc4Pk58g2j/q4eXY7lzzc3XCy7b9cN/hX+wFPddmEZHDwT
 7BseF8k/nPCII56gJPqJECwZuCFd4dgo+5zi4rOwwwRPlWXWvkyPNpGinjmXMdnD9dsS
 +gx2gjwVssM5Vnf5ws3YPDrVOZ3mg6+qcAC7JTY6wV4mC3dQeZq6qTYj5pOvXe8jtczB
 wwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793972674; x=1794577474;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rZtFwhZNNp3I4CxFlYMx4Z+4Hq02VTYQrKNwwmgilIY=;
 b=Qe9pjCUoCBH2RCTLxrmxcfNKVJTMI9oDYOXoyns2NXWcsvelXdforEhVlLZgbb+kAN
 fGpWLXU8KlC47kuVKnLrB3x1QoXHSDY/rZqkcT/kASlqA3z2nwNFH1F9th/IsPRHPXid
 qCa/GppQCg2a5Ez6oHsiIiQzkm1JBopRa0SzndLGx/0xPTBeusp+mrLmpyGys+jL0rfN
 NQzkJzsC+ij5+ZCKPVd3+z6ZpynrUp/kzbiXZbZSthYJ8uBa3JQRlbh1I42A0p4lNNzU
 e5gB+p1hdbvu3hVBztELdU5UC/Q3rUfT10UjwnmT0+lq5RNLC19mBqX1yEgolbThngkN
 3VAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqa8biBwANy83qNEshjCOUrEvUtU8JVkOK5zLCz1iungzHxfrpXnilBVwjewYh0GbI0tDVM40Mukc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Pws91J4Cf4Nd7c6ZrrEVuUVAfNZDdmIYjHLNU7eugBhwK2NYL
 SCpDZu7PNB6zh4HPalPgxrHKbSlYYXcr8PWnIKzB9LDqnGvwoTzvFAUFhAAiYUoUzf8IFqjvIlD
 Pcqo2emWB5IrfiewM2cn5kssOtQIaTgiRb669xA4RkdM+ZTQuQ1qbsg5kbXTIZz9XLhdrV5Y=
X-Gm-Gg: AYBFou0DgDPGWV/slXwQHgyfHrHzZNNqOZDPSMkXl0McrE3YJB7nIIT+oZK3M6tZfW7
 rwnb/mo+U6FLB1n+Ns8IU2Q6wl9S3KkFTh/cRg0KBPCd3uE5BA4xhYBdXrpJgNQrUv3umcdRpnm
 7MKe3r1NBwM7g7zBR9EDBA6VWeEs+p6brZf49QCz+ml/7dL5To28io1hidJ7m3ZUgRewKyRaq+y
 b6xBgcjUyG3mHgqf+X7MOPjZwwY7kj+nihpeVzonlo0Urx6VCxMbuyuarTQ9iPSVjWP+9Qla9/Z
 /cTf0YPWI5i2W7A74ggUAZsixVf7uaJYppcv0QlS4NiX30rtG/72ddpa+eyb7xYU6zpom+xHYNp
 fAcn3UKFtVMdlnm+wSuvE/6Nev2teyZKfBB8xKV/RJuH//I/v3iMzuIMXbFGi53RLFziBJL58rn
 9yS0YTTw40vSMXRbDjXPPXsPE275sj7AzNpk1JUbWuB0NmpeBf41aEQ95iDUB5WQ==
X-Received: by 2002:a05:620a:258b:b0:93c:3863:ff7f with SMTP id
 af79cd13be357-945e1231638mr926071585a.0.1793972673668; 
 Fri, 06 Nov 2026 05:44:33 -0800 (PST)
X-Received: by 2002:a05:620a:258b:b0:93c:3863:ff7f with SMTP id
 af79cd13be357-945e1231638mr926065385a.0.1793972673171; 
 Fri, 06 Nov 2026 05:44:33 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c003055a5csm382747e87.13.2026.11.06.05.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:44:31 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/8] drm/msm, media: define the UBWC buffer layout
Date: Fri, 06 Nov 2026 15:44:06 +0200
Message-Id: <20261106-ubwc-format-docs-v2-0-82949f88f030@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKbZ7WoC/2WNwQ6CMBBEf4Xs2ZJtbax48j8MByiL1AjFLqCG8
 O8WOHqZ5CUzb2ZgCo4YLskMgSbHzncR1CEB2xTdnYSrIoNCdZKojBjLtxW1D20xiMpbFibTCk1
 GUhsFcdYHqt1nU97ynXksH2SH1bM2GseDD9/tc5Jrb9dL1P/6SQoUx3OGWqNUpaarZ05fY/G0v
 m3TGJAvy/IDe5QvzskAAAA=
X-Change-ID: 20261027-ubwc-format-docs-7942079e1472
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Bryan O'Donoghue <bod@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Robert Mader <robert.mader@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3159;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QToJndkODS7Wj1YHga1gJRm6FhemYLcKo0eeSk+YgxM=;
 b=kA0DAAoBizyKPgIpKNUByyZiAGrt2aqh4rO0+jTXqtLOsn8CGU654vcQ8JUTBZXoX7TpE03sB
 4kBMwQAAQoAHRYhBExwhJVcsmNW8LiVf4s8ij4CKSjVBQJq7dmqAAoJEIs8ij4CKSjVgwcH/0zr
 wV15bo40Cu8PIUFuvzmC31vBuhBFrKwZt4mUUYC+cl+bJV17oEHTKzywvuakL40gNy4pHizHP/C
 3MpM5PTgjyQCZuXvpY+qKQCs/9hDiixtfbx8Yd6D0Rak16/TMGw1J+CwOEY892pdraz9LAdNELR
 WreE5e1vxav7YDr237+PrCgwzAwzuE+s39W89Imm98AIzT+MS8ApVHsV/Ok1Fi0aVlKEaKFdk2q
 Gtui+o3H7/GeLqOsD/XrGKnQ8CAWUFnAdHllryrTMt92dZP39qcxW1hoD2nhWhT4bCnZsYhoLUX
 a4lkP64czSXyE0rLTCnd56zjRN7i0fiwJoHKzp4=
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfX8D+j0WWEsGYs
 6kD+msVzFgcmvZp+MHI96JeO4YwIefwVvEwnS1l6U4W7WVZTAVhbbOwkxlP2Hb9wtwfB4cmnvmv
 lag2vSYKn2ccIVUjcl/y189XNcipF+I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfX4qiQBuw5VFeD
 POPsvXceMuouCz0o5e4h9DIq6+t9YJmENSVNSZ2EEtJWybSXqgaUeOquX0M9jg9Z2y1vW/i/9mW
 bHBpRVCWCZmILhiKMiHD+8JXOEiHbpjGVpypOwOCOtVXtNquUtR/ao85VZYHCk3ex3owJU2Wd3a
 DaBLSQZQJG0812gXSUZ5uQTYVnfQ05QGI7INSyJK8fhhBAqwCZwSmmEKB9J2NTUX8tbTCEuuLw+
 94+VW8SHemXglLRkdmIR8FSojYYzd8NfRkPUk2UlArWx1JXEeuVUg9Gf25fB6NL2wMUbC2SGhdX
 2rdWduYpq7X+hkcGat9P6ZaL2GxZTKRpCfRPwU93NsmL10XggOFK+q0FqmyZf1eZm+8xP2JF/5L
 yYeiNh+f+KOzG/wMaJ3c8C3lInPpZi4zntZwTXRVWznQqwHSiBm+L1s3MjoHiAtSGhJ2PXrvIVO
 MtmoPWTyTGy8Rvw053Q==
X-Proofpoint-ORIG-GUID: 6w3XL266YFWCKT6QK9iueXjKFYo_NEOV
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6aedd9c2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=7UXMlWAF346c1l6B0ngA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: 6w3XL266YFWCKT6QK9iueXjKFYo_NEOV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060054
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The layout of UBWC buffers (DRM_FORMAT_MOD_QCOM_COMPRESSED, V4L2 QC08C
and QC10C) has never been written down. The V4L2 formats are documented
as opaque with four or eight planes, the DRM modifier as "macrotiles".
In practice the video decoders, the GPU and the display controller
exchange these buffers, so each side has to reverse-engineer the layout
from the other drivers. Nicolas Dufresne asked for a contract to know
what the V4L2 plugins have to compute when passing decoded frames to
DRM.

Note that patch 2 changes what P010 with DRM_FORMAT_MOD_QCOM_COMPRESSED
means: it used to be set up for P030 (TP10).

Mesa 26.3-rc rounds the NV12 chroma size down for odd sizes; that is
being fixed on the Mesa side, before the layout reaches a release.

Tested by decoding a clip and scanning the frame out with the layout
documented here: QC08C as NV12 on RB5 (Iris), QC10C as P030 on RB3
(Venus) and on RB3 Gen2 (Iris, gen2 firmware). Each frame is identical
to the same frame decoded to linear NV12 or P010. Compressed P010 was
tested on RB3 Gen2 with a frame written by turnip, with P010 support
that is not merged yet.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Described the compressed 10-bit format, P030 (TP10), as P030 instead
  of P010, compressed only, as the SSPP can't fetch linear P030; gave
  P010 a UBWC entry with 16-bit samples (Sashiko, Robert, Rob)
- Documented P030 next to the 16-bit P010 for QCOM_COMPRESSED, mapped
  QC10C to P030
- Explained how the meaning of compressed P010 changed and why
- Venus: dropped DRM import as the reason for the stride fix
- Link to v1: https://patch.msgid.link/20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com

---
Dmitry Baryshkov (8):
      drm/msm/dpu: fix the comment on the RGB UBWC plane count
      drm/msm: separate compressed P010 and P030 (TP10)
      drm/msm: move the UBWC plane size calculation out of DPU
      drm/msm: check UBWC framebuffers against their layout
      drm/fourcc: describe the Qualcomm UBWC layout
      media: docs: pixfmt-reserved: describe the QC08C and QC10C layout
      media: venus: report the QC10C data stride
      media: qcom: iris: describe QC10C as P030 (TP10)

 .../userspace-api/media/v4l/pixfmt-reserved.rst    |  64 ++++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c        |  84 +--------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |   4 +-
 drivers/gpu/drm/msm/disp/mdp_format.c              | 113 ++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_drv.h                      |   3 +
 drivers/gpu/drm/msm/msm_fb.c                       |  39 ++++++-
 drivers/media/platform/qcom/iris/iris_buffer.c     |   2 +-
 drivers/media/platform/qcom/venus/vdec.c           |   5 +-
 include/uapi/drm/drm_fourcc.h                      |  64 ++++++++++--
 10 files changed, 271 insertions(+), 108 deletions(-)
---
base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
change-id: 20261027-ubwc-format-docs-7942079e1472

Best regards,
--  
With best wishes
Dmitry

