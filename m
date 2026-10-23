Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D260A2627
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HNB+HFsJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZpbjW7f9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F601112D3D;
	Fri, 23 Oct 2026 23:25:50 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C95C10E736
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:39 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLv7NW3683561
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qOShQj0uJ3d7Zum6NFZJy8
 Ct97Abc7xdZVqjTNdUtKQ=; b=HNB+HFsJL5Dr9zVCeGPuJQjarVVSAHU64ikXrW
 1gIOq7DMgLSduKhzEMtaU5zrxUEYb/5/C+PvO8c4bGKDLxjicu1oikWKoEfBj325
 Wki4aSBxz4ZNf9TfanMltY7LSMi41mmy+vTdhsVBY1aaKbaKKySxMlBr7Iw2XYrO
 I3Lo8w35z2YTgjnV51iFSHqZ0R1k7Oh0u5Aa92/g8JOnuoNoITNa/0D/hvbyHIxU
 qYyKC+SxFTzIEZoyYjomOATTFNNAcvKFD6Ywv9SBTPFwPPgzaDjPp+0X8cjs2jlv
 qv/UlZ9OkvqdqXKwIOfJXYx+obSslNY9AsaUtML8y+lc3DJA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas6sbk9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso185597385a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797937; x=1793402737;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qOShQj0uJ3d7Zum6NFZJy8Ct97Abc7xdZVqjTNdUtKQ=;
 b=ZpbjW7f9d7IfkvMXIINKiZjt025cNTq0UwewRQuCpC3SsDJBiyPG8O47yaquaJQe8m
 gbrUOUzST4nbdeXb9KW8lb7zhY0fv3rigqfgxDgEz94Xvv7YEJr52woVhMAs5GrzDjc5
 Br/Nzy9EhGTyb+awLTR5qwclp1kjTkknw3Aw+yfP3NTUpyHnFXu/13HmKQfP9MuHhMG3
 j94DoZhx/jGooji2M4D2r8KPSwizDfs9aBeoENBVOtQq9EvV8a9MpbLWaUSyaLxxtD8s
 viUC8+UW8zSoNy9EgLpYRJlw5/jHd4gm0rvJOaSXei4UWhfzcXXjkpLnhpIW0YgR7TRy
 u3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797937; x=1793402737;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qOShQj0uJ3d7Zum6NFZJy8Ct97Abc7xdZVqjTNdUtKQ=;
 b=Nf5mRKwFquU3Eoyt5U4MPqj0yYTFJ1MCJ2shWGtCdcFz+ZBTg7ZGKXF+sMI761Laxw
 K99Kp1EBAYfu1WdutO0qQiilxLc8b9L8JhM/iNGFMbxLiQZftkolhdM+KyPpWBO0GpMp
 TgmuSg8Nfg9YPJOW3+IQoS+kVLXg7XYgt+zVjt+eJWkstJSbvqIUzO0iviAlUCpVSVtu
 936IUrSwIqNYaL8hGOqzXRovHnb7WNsNzA00KqVb1deTeNN9hzLHso+j/veVhz/C4gXv
 IPY8P2uBYRuJi07B0bqc7HvQFstqb7lSBRRdAjyhg9FC7nu6vWFGt9JPkOKdDfU53TL+
 76+A==
X-Forwarded-Encrypted: i=1;
 AKwUvByjlwvT2r4YOK0Yi4qXvCLVXS65NjvuotT94j1W2hHaUv9G/7JpsKjCzNkKepLY2hvklZ8P3p8A2JI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKHlyk9cjDWSnhcGwGJneTwFk/3RR4Ype562u3tAEHIhv4VC1vD
 YYidIsS/mqubKaqsO350EVIy+iqDYKa1dKTBa00RcuEA3HgB3o+xnqt8LcJH1cjRuWAdJ16/wsK
 nDkkAJ5uwH0YZmmy1jVUlUhh84xqfnjHWwlNYUIvg8dGFQ8Ab+VKTL/2nc51JtVUTUg1oBi4=
X-Gm-Gg: AYBFou1CprmSW4EY6gniW3BuuL7FuAzC08vHO3Xa4FgXveqoQ6SHMy6dJB9w90gK9ch
 zpfjWPAGmLGkTupRMg3zn8JoMgqJROtsBydAS45qbymQZbqImPlBKJymlJnPhVAZm+wHmdNZOjF
 A2fXbLUUpnrt3Of21JTw/Lh324YeDLBHQSKUltEBC3K39HT2In6Xr+mIoWbTO7qBb1hST1y8/Sl
 0vP5OAnnQ98i01bjCRnYOK8Sm05jyuG8GP6R4+WDF/dcG5b/Np0KVIcAhryJjN3pYlgGef6lYX7
 1rDX6II9Hrih1Uq4cCtgERkRPiu4WKcCIgaDwQKnS7pQx6mr/3fu1/O/UfPR1o34ORff4OFMWj/
 YcIccv+hKAXTla2E29qyYyslT1wFs1J3jHZNH5mtjlguDyoZnj+M5c86/Dlfc105qcr8HLecjx4
 Tl0GvCxLItoWAt
X-Received: by 2002:a05:620a:3184:b0:93b:d79b:9a57 with SMTP id
 af79cd13be357-940ef986b38mr82194485a.56.1792797937130; 
 Fri, 23 Oct 2026 16:25:37 -0700 (PDT)
X-Received: by 2002:a05:620a:3184:b0:93b:d79b:9a57 with SMTP id
 af79cd13be357-940ef986b38mr82189685a.56.1792797936586; 
 Fri, 23 Oct 2026 16:25:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a9ea71sm60217e87.81.2026.10.23.16.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:25:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 00/10] drm/msm: fix SMMU fault dumps
Date: Sat, 24 Oct 2026 02:25:21 +0300
Message-Id: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOHs22oC/3XQ326DIBQG8FcxXI/u8KeIXu09ll2A4MpWdBUlb
 RrffYjN1sT2huQEzu/LxxUFOzgbUF1c0WCjC67v0rB/KVBzUN2nxc6kGVGgAiqguDX42wfcujM
 O3k+YGq6VarkADSht/Qw23WXx/WOdw6S/bDMuzO3FYE9TihrXZ/9JdbHmMMA++BxkbBiH/oIzi
 qEFrolhlZasjmzhtAoWN733bqyLtPW6bHb2PKIl/uDC2A+X3C+SnHarwjZVIsGABUgDlFdECPH
 Wh7A7Teq48Lt0ZDLSe0ZuGZqYilVEkn3JqZJPGHbHkO3HRpYYVRrTiNZSYPQJw/8YAo9K8cRQx
 bnhRqqmLB8w8zz/AuOWy/4JAgAA
X-Change-ID: 20260902-fd-kms-fix-smmu-2d4baaf460b0
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7388;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9gsbuRhdPFZBYfFXXLiFzSoka9OhpnBxLUCPjEMIkCI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+zkRr6us/8hNHsNgb5tgofxHAhUjPEDTPbOY
 lH50yJm7WeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvs5AAKCRCLPIo+Aiko
 1eXDCACk/6aB01Sj/56mDQmedmHP+qhgXyddQK6bPz/xNwRWcf5RLsLKjhQJbPYQMOc6r5Q8bmW
 tGA6zwx6mXErRCXVO1OSGkcoGID8aHe24FSEYpQd78XE69roCkQ+06t1rn3uS20iAcS5czmKfLu
 x8mBm2J0DQavxjJIwlck5hFATk2ZjrfVytNtagCCIxMYcQzOP1RExSYW0TTDYNxSKH0RiUV2rWS
 SFDWTPv4924MOoCbRqyzBe4vdjy6L6jnAT92u9J//BCKPv3j4WJKsKtiNxHABUDYYgQDppM+K2O
 46R62wHGJtaBKn1ZQJcuUWqXBvKPUdyhfS8C4c89Pae432mH
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXzBljZoNfgiMt
 sFZWSCYiPn2jFupdJqSFAwRDRdUco7XXv5rRp3w2Xn0OilndcX4MKXe9N+Tgl9h4LmPtnKuRBSx
 y+FHIza9pS3Y6Ie6vuOy1rVVHl/531LywTlsOebH+tI5aXFpQ4FdPGg8V52XuSYlxJhCPIlZyIy
 VFNiHWcULU7dNreiMkIJPm+rEiROW6qqks/dxNMJxq4wAxtgh1kSnjvzMFatvYdIoBrYxQwXvXe
 WO2ooe3l9VJt2N89DFvc0u0HCZhXRsmjycNqtcPkQny9OHyJbnyvoIIDlYHuUGarQ7cKY4XlU0y
 6sN+kLvUgVSZb1az5hr0kfOwzPh6uuNmUjizFbPJ26muEZUUjEkelLbVUZIkeF48gX84CbTlExk
 y25QogJVKS8rS4wfMqTrViY67sQsZ3IbnhlpB07lPUc1GzFOVbf6JtdDfmhprQTNlvhUCTzAhLe
 XYlNdagZssOO+BFDr6w==
X-Authority-Analysis: v=2.4 cv=DK0acCNb c=1 sm=1 tr=0 ts=6adbecf1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8
 a=COk6AnOGAAAA:8 a=QX4gbG5DAAAA:8 a=QyXUC8HyAAAA:8 a=e5mUnYsNAAAA:8
 a=9OaiLBg4dggejaDBeAYA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=-BPWgnxRz2uhmvdm1NTO:22 a=TjNXssC_j7lpFel5tvFf:22
 a=AbAUZ8qAyYyZVLSsDulk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: BUq2LprpdF2hLlwlJoceNHIHpDhl7rss
X-Proofpoint-ORIG-GUID: BUq2LprpdF2hLlwlJoceNHIHpDhl7rss
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXwfAH57h/j7AY
 M2LpevMxiT02O/9xJ/x+sLKYABhEJEvvquXn2WGfB5VEJLlq13TdNMGEWLQoSJKQ6xKhq+Y54eV
 WwWVH3S7lVITNfpLB4Of5E5ncO+l7+k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230092
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

In several cases the drm/msm can cause an SMMU fault on modesetting (due
to the display controller still scanning the BO which is being
unmapped). Fix the cases which I stumbled upon, together with the issues
found while chasing them: hardware block pointers surviving the
reservation which handed them out.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v5:
- Rebased on v3 of the KMS init series
- Keep the kernel-doc of dpu_crtc_check_mode_changed() on that function
  rather than on the new helpers placed in front of it (W=1)
- Explain why msm_crtc_vblank_off() can release the pending framebuffers
  straight away: the encoders have already stopped the timing engine
  (Sashiko)
- Link to v4: https://patch.msgid.link/20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com

Changes in v4:
- Take the framebuffer pin lock with guard() instead of unwinding through
  labels (Rob)
- Move the fixes of the KMS init error handling, including the unwind of
  msm_drm_kms_init() from v3, to a separate series, which this one now
  depends on
- Add a retired framebuffer to the pending list and schedule its release
  under the same lock, so that msm_crtc_vblank_off() cannot free it in
  between, and track whether the vblank is off next to the list rather
  than reading crtc->state, which a later commit may have swapped (Sashiko)
- New patches, ahead of the DSPP and DSC ones: clear the CWB and CDM
  pointers left by a previous reservation (Sashiko)
- New patch: flush the MDP5 interface before starting the timing engine,
  otherwise the first frame after a re-enable is fetched from the
  framebuffer scanned out before the disable (db820c)
- Link to v3: https://patch.msgid.link/20260912-fd-kms-fix-smmu-v3-0-a7ddc6fe2032@oss.qualcomm.com

Changes in v3:
- Initialise the framebuffer's lock and dirtyfb count before
  drm_framebuffer_init() publishes the framebuffer (Sashiko)
- New patch: unwind msm_drm_kms_init() on failure rather than handing a
  half-initialised kms to msm_drm_kms_uninit() (prompted by Sashiko)
- Drop the pin count from the deferred unpin work rather than from
  ->cleanup_fb(), so a framebuffer scanned out by several crtcs stays
  pinned until the last of them has passed a vblank (Sashiko)
- Defer each retired framebuffer with its own drm_vblank_work, as i915
  does for cursor framebuffers, instead of a per-crtc drm_flip_work: the
  release no longer takes a detour through kms->wq, and nothing needs
  setting up or tearing down in the kms init path
- Release the framebuffers still pending on a crtc by hand when its vblank
  is switched off; its interface is already disabled by then, so no
  further vblank arrives to run the work
- New patch: clear the DSC blocks left by a previous reservation, the same
  bug as the DSPP one (Sashiko)
- Link to v2: https://patch.msgid.link/20260908-fd-kms-fix-smmu-v2-0-9391815742a8@oss.qualcomm.com

Changes in v2:
- New patch: lock the framebuffer pin state, it was updated locklessly
  (Sashiko)
- Do not defer the release on an inactive crtc, it was leaked there
  (Sashiko)
- Flush retired framebuffers from msm_drm_kms_uninit(), before kms->vm is
  dropped, and only for crtcs which have a vblank work (Sashiko)
- Clean the flip works up after destroy_workqueue() (Sashiko)
- Fixed the long-standing issue of the msm driver roguely setting
  allow_modeset, which started to manifest in timeouts and SMMU errors.
- Link to v1: https://patch.msgid.link/20260903-fd-kms-fix-smmu-v1-0-608d02491666@oss.qualcomm.com

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Antonino Maniscalco <antomani103@gmail.com>
To: Kalyan Thota <quic_kalyant@quicinc.com>
To: Federico Amedeo Izzo <federico@izzo.pro>
To: Helen Koike <helen.fornazier@gmail.com>
To: Vignesh Raman <vignesh.raman@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

---
Dmitry Baryshkov (10):
      drm/msm: serialise framebuffer pin state
      drm/msm: fix framebuffer pin refcount leak on prepare failure
      drm/msm: release scanout framebuffers only after a vblank
      drm/msm/mdp5: flush the interface before starting the timing engine
      drm/msm/dpu: clear the CWB blocks left by a previous reservation
      drm/msm/dpu: clear the CDM block left by a previous reservation
      drm/msm/dpu: clear the DSPP pointer when no DSPP is assigned
      drm/msm/dpu: clear the DSC blocks left by a previous reservation
      drm/msm/dpu: only reassign resources when the encoder is reprogrammed
      drm/ci: mark pixel-format tests as passing on SC7180

 .../xfails/msm-sc7180-trogdor-kingoftown-fails.txt |   2 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  36 +++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  23 ++--
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |   3 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |   4 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |   4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c       |   3 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |   2 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |  17 +--
 drivers/gpu/drm/msm/msm_drv.h                      |   4 +-
 drivers/gpu/drm/msm/msm_fb.c                       |  75 ++++++++---
 drivers/gpu/drm/msm/msm_kms.c                      | 142 +++++++++++++++++++++
 drivers/gpu/drm/msm/msm_kms.h                      |  19 +++
 15 files changed, 276 insertions(+), 62 deletions(-)
---
base-commit: d024361c631b3f020a26c07d683e5103404b0fbf
change-id: 20260902-fd-kms-fix-smmu-2d4baaf460b0
prerequisite-change-id: 20260930-msm-kms-destroy-fixes-0f04b1d39b83:v3
prerequisite-patch-id: d7439e7df4daac116217eb0fbbc277974d8dc1c9
prerequisite-patch-id: c1e587e18e63a6d5e97326ea2d93f58bc109ea89
prerequisite-patch-id: fb2a9d3af5c8fd52a0a3907f20f6b90661664dcb
prerequisite-patch-id: ed404293463bd438758cb0d1ed48b0c4c6de161a
prerequisite-patch-id: 5519e2e012b2065c08849502118233ccfd61e9d3
prerequisite-patch-id: 09f7ca53872a2ab17488f2bb94a1c2cd4c396781
prerequisite-patch-id: 3bc29c32e4b7fa71b785e0f7b6e16aebacc5be60
prerequisite-patch-id: 63305cbd316626057e69ebafd6689daf10f2d2d8
prerequisite-patch-id: 11dc97f7f4980bdad49123271651749d0a8f8d23
prerequisite-patch-id: 79bb5b490e30ed65caaace15d025974ada206d86
prerequisite-patch-id: a1d0abc303bb5730ac9901a29d678db593ccb55b
prerequisite-patch-id: 346f4bad40a14c72fe5966a9adb0d258592bb546
prerequisite-patch-id: aa59ee029b6f5b24d6870208ebe8a5464204cad1
prerequisite-patch-id: 2830113c25f6fafe3857fbd4685efb161d19984d

Best regards,
--  
With best wishes
Dmitry

