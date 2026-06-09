Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29F1CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EB6A10E1DB;
	Tue,  9 Jun 2026 09:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Htq4LEXK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lf0nnojf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E1B10E1D9
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:46:40 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6598Wlsf2130240
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 09:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=41ORP2MeswFXH5m5KFacwW
 q0dcdcSXNSZxua2whrjlA=; b=Htq4LEXKMmyVYnH528VzMdZ+JVZhrlrxAhZJp+
 CQSEEp3FJX/DXqOS/cM31xpUk4DYKq6DDDNTmH0CELTKcwHoVzg16l5ATrarYdxB
 HahCjfgfAWPslgGN0moX+ozbD9o+VJq+iRoSWQCbZDTYnCfKIeNBphwfhxZYX2L9
 X5jBYWgiDY0KL7nIvu1SfKCri/LNg7k+IXR/ni7hWz/ChyQkRV9TYpkAyHX5ssZb
 R9LwONB2a/b6cUX7EEApcxFoV+cmux1OvrWs+caiL/4HYvooKNM4yTjoPfYVvdC2
 kU//oS/mqM0OlAJUvoAYrv9TVwYQc6k7rg9YjxyLkeBQVITA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epfdt0a17-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 09:46:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9158f2c4b55so1044866885a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780998399; x=1781603199;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=41ORP2MeswFXH5m5KFacwWq0dcdcSXNSZxua2whrjlA=;
 b=Lf0nnojfTWDhq01b/CFGdByZGS8v5O98VvwC9lBKqoGElacCWijAhTAedDz6M7rNBY
 +47Ji7DrCS9fda5I8dmUahLMgZS2ESRfTZQoQ+LR1HI84wOmGsp+38WJjX6KmQpvz2rd
 k4nvfKhYKZAm9MEBOGXidUTZXBX+F/1gkm9BHIjCeFSRZcvjFZJDVcPkI3UEn8ImkJ7M
 4N+kHj6VV2BC3Tqpw/hNSV9bh168oF/47xXbqv0yxiUpatY5tgl6uwIM1xggB0IaZVMg
 ak3d1qmPYRknOzaNkhuElixEYKdFZkg0XIXnuauXPBbnrWgY4eef4ts93hr4xP4GB8sm
 GlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780998399; x=1781603199;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41ORP2MeswFXH5m5KFacwWq0dcdcSXNSZxua2whrjlA=;
 b=oGfSn3sCIyt2MwEyVQ5CmzpdlNhRlJQ9zlM3675EVFyw3VKP28bk5TKBL4/1a+gYEo
 f1GbETeemNmNpSCfDHyt3jYpiNuEK7XL9DnyYHzxYc6TTmygCk+MkjaRzDyYeqPvOg32
 CfuCpailu8QQjS42f2YoZQnfMlpZv3q+ByUtm2bhEIvpOHs7IyXWqoPllgxthws2i4Kv
 fVVbekArPJqA9a6KQ5plLSbmjPgasGBNP6PUftI9tQl0YmJpC7S1QeXCvGMd+UB7QDZg
 DTZo7skqXZ1sEu7S69stdhpyES4IdkUjSaX3saBPuLYWpawy/heGsENt17CCk4OZjGKK
 HUCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KvPoLBBLVaiUgMmmiukK7Z1+Mf+yhuBsPR4Iime7lDLTBOKQt+RYJ3rjlj5WQon5G8Ned2zf4IOU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsPOfhamdTNChZepeDteSsN+YckLetajw/F9hISg8FEIROrsXc
 RZZs8GRthy/hfZG4sG/0M3DsfvN06YGRhu3yUV+wZiyuEoRNuPlyAKwTH6TXKTPYvybwttxCPVd
 sxxeG2MLKbaUU7FMrFshByR/II3ErNAyT1ut2GkLhDhAtRnPeblDc4Ql/+D4ETemVZ+wcJ/I=
X-Gm-Gg: Acq92OGxhcOIGBBLKfLGiAdawRnb64Gg4opZit8ceE5Es3ryrbKYCcBxJVfBXcSiy4E
 F5bYnHleKwzH7TKr1vbWPGZAjBYQ7eAZ+cjRpaFCCCqmkXoBEuBLQRLTY3gNK4L8ORnnLX3m0IG
 Tpxaaicg8uaLZRqSIy8YF91ndmO8iT8HANE71/fdwfqCEcgQenZKBvbcz8/E0tyP3PjaN98Zdbo
 6iUXvDbOGRLp5oHXM8g+kz08ShP5179mD39yjsbDLSJUx5WbhxvXJIyChEljqolwpjnudmkFCWX
 c+v0AGoPrih9sbjL+GDYqO+9ocD4sqp6DOw0c2atrneUksf7YSAWaAx0xrEJLVgjsOyPd29pZTK
 ZrU55uTG0Ea5O8/7wo0T99ZVM4oDOmZaKwhnyzI1WbBHRmSE6+fSHniETrm3MiFS+GbfElCfDy+
 PcU4tnRYY5Lxcb+sbxbQ==
X-Received: by 2002:a05:620a:1794:b0:915:d5cd:8ce5 with SMTP id
 af79cd13be357-915e82543f5mr233083385a.20.1780998398876; 
 Tue, 09 Jun 2026 02:46:38 -0700 (PDT)
X-Received: by 2002:a05:620a:1794:b0:915:d5cd:8ce5 with SMTP id
 af79cd13be357-915e82543f5mr233079885a.20.1780998398298; 
 Tue, 09 Jun 2026 02:46:38 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00afafsm2047489485a.2.2026.06.09.02.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:46:37 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v7 00/15] drm/msm/dp: Prerequisite cleanup for upcoming MST
 support
Date: Tue, 09 Jun 2026 17:46:22 +0800
Message-Id: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO7gJ2oC/23OwYrDIBAG4FcJnteioxm1p77HshRjxq3QJK2mo
 UvJu69ND8tCLwP/wHzzP1ihnKiwffNgmZZU0jTWYD4aFk5+/Cae+poZCEDRguX95TiUOZzJjzw
 KpwN5GzxoVi8umWK6b9rn1ytnut4qOr+WrPOFeJiGIc37hkxvhCCpndKENlpUyoYWpQgRPBk0z
 naIij2tUyrzlH+2oku7YW87LS0X3DsAGWSUUXWHqZTd9ebPz7e7OjZuwT8CBfwnsBIQpIlRC+8
 6eEOs6/oLW/VZADwBAAA=
X-Change-ID: 20260528-dp_mstclean-f094cea8ca24
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780998392; l=3468;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Be/+PZJfQrdccu2rFfueIgde382kPm+vs/NQWA3++Hw=;
 b=yVfbiBr6+L9sSo2yi7XTtFRsXQuPIPyYRDyYy1ANqCEi31RwGrI3hC70IBjGklX5BMjQ3HOEc
 Fkr/Clx8tkTCReYi1JNpS5pWX28Nqrg4YhOkSqxCsQak0C83/I8U4qi
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: EpxCHza6SgYRqpIwY-BBwiFCWDhl6YxT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5MCBTYWx0ZWRfX0/MXs4HSEsPY
 jB6wg8x5mDZlrDcqUnKI8C+HtfencRiJnDR/V7L36T/i6aOqLb4/jyDxd98NcyUuwBqg4G6Rh3/
 IZ0Vepwigm7B7GhgihT5v4xcAE0OAM4D7GFrgqGV9SE9F+K+OLxQ2w3sI/k79hA1BpEke7tGPr6
 KfLFgMrUwEyUDvsyN6O/lde8C06GhGrdE3+CSlw0X0PBbPeV/2FFKn1d0iPIZyIlRbxDqvpuDNB
 gyr/b5i/+EMS+81YDaLTKogFh6YCmoK3o2boRjQghGB379Jj+BhdJZ+N2PJGoWRjKd3ONK1xx1t
 oNQn8X2KmVbZlDuo10F4841B/Qek48F2KfBCNMdu+NISYg+tjqtX298fbiJPhzp/JfOv1Hj+CJK
 7IcsWHbAIzTqTtl/oIvFL9LaUoZlS+YxEqDgSnnXkGZYV36mG42pa/80Npo7yzJP4cj66LqL9fm
 lKj0HYGVnj4Qgbsx9tQ==
X-Proofpoint-GUID: EpxCHza6SgYRqpIwY-BBwiFCWDhl6YxT
X-Authority-Analysis: v=2.4 cv=doTrzVg4 c=1 sm=1 tr=0 ts=6a27e0ff cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vykuwZLdp5Yjkddl-pAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090090
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

This series is the SST-only prerequisite portion of the MSM DP MST
work. It refactors the existing DP code paths so that MST can
plug in cleanly in a follow-up series, without bundling the cleanup
with MST functionality in the same submission.

SST behaviour is preserved end-to-end; no new functionality is added
here. The intent is to land these refactors first to keep the
follow-up MST series focused, smaller, and easier to review.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
Changes in v7:
- patch 7: Use WARN_ON_ONCE() when pixel clock is already on. [Konrad]  
- Link to v6: https://lore.kernel.org/r/20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com

Changes in v6:
- patch 4: fixed the RMW comments. [Dmitry]
- patch 10: do not rename the existing struct. [Dmitry]
- Link to v5: https://lore.kernel.org/r/20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com

Changes in v5:
- Split out from v4: only the SST prerequisite cleanup (patches 1-15)
  is sent here; the MST implementation will follow on top.
- Rebased onto linux-next-20260527; adapted bridge callbacks to the
  new drm_atomic_commit* API.
- patch 3: added Suggested-by: Dmitry Baryshkov.
- patch 4: fixed "splite" typo, reworded body, added RMW comment
  covering both SST and MST paths. [Dmitry]
- patch 10: drop cached panel from msm_dp_ctrl_private; pass panel
  explicitly to all stream-related dp_ctrl APIs. [Dmitry]
- patch 13/14: introduce bridge wrappers and atomic_prepare with
  drm_atomic_commit* from the start to preserve bisectability.
- patch 15: fixed pass panel inside the func. [Dmitry]
- Link to v4: https://lore.kernel.org/all/20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com/

---
Abhinav Kumar (6):
      drm/msm/dp: break up dp_display_enable into two parts
      drm/msm/dp: re-arrange dp_display_disable() into functional parts
      drm/msm/dp: allow dp_ctrl stream APIs to use any panel passed to it
      drm/msm/dp: split dp_ctrl_off() into stream and link parts
      drm/msm/dp: make bridge helpers use dp_display to allow re-use
      drm/msm/dp: separate dp_display_prepare() into its own API

Yongxing Mou (9):
      drm/msm/dp: remove cached drm_edid from panel
      drm/msm/dp: drop deprecated .mode_set() and use .atomic_enable
      drm/msm/dp: move mode setup into msm_dp_panel_init_panel_info()
      drm/msm/dp: split msm_dp_ctrl_config_ctrl() into link parts and stream parts
      drm/msm/dp: extract MISC1_MISC0 configuration into a separate function
      drm/msm/dp: split link setup from source params
      drm/msm/dp: move the pixel clock control to its own API
      drm/msm/dp: simplify link and clock disable sequence
      drm/msm/dp: pass panel to display enable/disable helpers

 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 382 ++++++++++++++++++++----------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  30 ++-
 drivers/gpu/drm/msm/dp/dp_display.c | 273 +++++++++++++-------------
 drivers/gpu/drm/msm/dp/dp_display.h |   8 +
 drivers/gpu/drm/msm/dp/dp_drm.c     |  43 +++-
 drivers/gpu/drm/msm/dp/dp_drm.h     |  12 --
 drivers/gpu/drm/msm/dp/dp_panel.c   |  75 ++-----
 drivers/gpu/drm/msm/dp/dp_panel.h   |  17 +-
 8 files changed, 451 insertions(+), 389 deletions(-)
---
base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
change-id: 20260528-dp_mstclean-f094cea8ca24

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

