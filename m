Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33B4CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C64610E06E;
	Thu,  8 Oct 2026 13:14:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fF8nR+ND";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fA6IrtSk";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0EDC10E06E
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 13:14:51 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698BKD7C1708164
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 13:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qXqSGRfxaKF+/oxVxM0Vor
 cAg5N4cAG4clbEEnHeqGI=; b=fF8nR+NDoM8035uniiYL2ifzgwXLtPwGJHCmGK
 M3zOO8UdIUVXAGLzAxVxeImR7riEaqTkSCKEfdJZrvsyqao8Zob8GwVla84Q8Kf9
 zwU/WGXcail2rG3V70iax4qksomUv+HgnTXc9+MK6f3lxKr/83tvuAk9oMh7OE3i
 GRUkUDHbMC2gYYst10XDEhkA9WE062YyH8oIdfX1t1qWdXXBe1Un9KSBzifFiunp
 +RGvtkaqkAZ2pLdW/R9BVqFql/1VNgxcqzFNWtv5vALfVMkJn7tVPd7doCxHLi/I
 BZwFrt0o22sGH2GdCJtCgFiIE1mHVsMkuTbmhBzfErpTnF2A==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3ayyq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 13:14:50 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-988c7363ee1so4165682241.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791465290; x=1792070090;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qXqSGRfxaKF+/oxVxM0VorcAg5N4cAG4clbEEnHeqGI=;
 b=fA6IrtSkLeyipp7UgE3QuJAf21tbzESxNmUa0/rSXNXNQuRxeAge3xi6fuws64cU1o
 fcz0FsWiy0WhPwJkBj5iNdbdihBJR51fKqWfBVNtVUwU1pfTGmKNv57JM+WnOeTWv9Z3
 MsT5fseQEnong+oHDZ+alVStPIQ3hx0zl/Tm1IjI6TT5csUPZk6VsDMphvnIQeuipLNK
 85bfLW2T7lJL3PFvVRNCDJt7E5LFjhRTCyh0nBeSJyS/ydK1Fql7Bx/Hqpf5MfWENN8r
 xw5xLK7ASjCKtpJnyO2ZaGZE8Nde2YM/fXSxQ1pDUgMq4kiJdQ7F9b1fptJkhANCP4eo
 vlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791465290; x=1792070090;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qXqSGRfxaKF+/oxVxM0VorcAg5N4cAG4clbEEnHeqGI=;
 b=1aq+nSWEdcg9S/dNlHLOEeMA8/b8FXr0GDqwZ3azB7U/i9JS5tpNLQemDt+N+uwSZ9
 ir/Y/WcUroz3OAv3izPOJKaT2IFr65gk0FAuE+g0U7vZ5RETnvUrCHi2HOO2FhgRGinq
 vueLUtZsmL5pRNkD6/GxY5Y/CvKitDgi6P5YpGGDBDJ4wgSzU8yopNzYe4X3U59Q81Vz
 weE3jBtTUP4GPxvAZRwkEmcl+kS9bVZZApk2aZgcjbTcYpf/ADjnAOtlVbzBw3mEjqBI
 IkXJemEEg0tH/LawqDFoJB6kfXDRm6JXe7sFE4P+7gi8ktdSs+kq557CmnJ+nmK5qR7J
 Wr/Q==
X-Gm-Message-State: AFq9FYJTbWWjORdfjQ9FEYrfk81mCHwgMWdyu9zwOeBuXN/Gv2qUKRh0
 Zzp7CcVC6z7rR6U2XCA7epUDtofCc4T0x7QhECdoZslZq2uBr6TsaBqiSgqlvG8j6H9V+f6cKnk
 705lx0FmE3MbDWpDZbJdSDV/bL8V58CO5AqS/ASAuJto6Ke8R22fSCQ2lDnTTOzQSN3OJ+nQ=
X-Gm-Gg: AYBFou2ynuYhseY9wFoErqFm/DTf0Vm14Th4fNjgKRiwnBEo6KAm+BA2UdDueyj05QO
 HiGlG20cV1hs1Zx94d31sR+kgMwen7FRxcnNvWkLwqrv5AXGZNSH/of7d4b/KXueC727X+MHbp3
 C4SRy3arG9SzyEaXnaKpOOgCFg62Jsq4aqUo7JlyVu55zCG0xun3GPDYL39Jv2r0qqT6hnKqova
 Lg5HOnTQFFWFZue5M1UMrF+uYdtWWYTRCopCYgxyorjEqw6pNURNSygYDelukSxSKgwP+ICMF5S
 HfOfSjDPKygzCSi5rWhRWJnS0hcRBPEbY4u/53bhKvkPHc8HBCtYhBloR5r/WWAo0JiY12zNRek
 XIYnY3BM9F9BKsXgfSNs3P01/ep6XavOpapYyf1Iat8WuJm0Ag0GqSnHNFCM1OWXpyWKKe5fHTG
 2Y4Psi7UK1JO2W
X-Received: by 2002:a05:6102:449b:b0:7c3:9982:67d7 with SMTP id
 ada2fe7eead31-7ca38b3a689mr1858090137.16.1791465289790; 
 Thu, 08 Oct 2026 06:14:49 -0700 (PDT)
X-Received: by 2002:a05:6102:449b:b0:7c3:9982:67d7 with SMTP id
 ada2fe7eead31-7ca38b3a689mr1858067137.16.1791465289234; 
 Thu, 08 Oct 2026 06:14:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9ae563df4sm8691441fa.30.2026.10.08.06.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 06:14:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH RFC 0/9] drm/panel: add atomic state
Date: Thu, 08 Oct 2026 16:14:22 +0300
Message-Id: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC6Xx2oC/yWMQQrCMBAAv1L27MK2JFq9Cn2AV/GwxlVXNC3Zt
 AilfzfqcQZmZjBJKga7aoYkk5r2sUC9qiDcOd4E9VIYGmrWNdEGB47yRM79SwNa5ixIfutabsl
 556GEQ5Krvn/TIxy6PZz+0sbzQ0L+7mBZPrVJPLJ7AAAA
X-Change-ID: 20261007-panel-atomic-state-05948a804545
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Val Packett <val@packett.cool>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3151;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+9FF7vQ8/k7WpN8Vr6N/Heg8/vdlCSMy+u+GgLfq6Do=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqx5dF4UdXo7V22tCGOX65pJsz5XA0Ma19w2j0z
 bYsIstcPuKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaseXRQAKCRCLPIo+Aiko
 1TgwB/9RkkrfScNezYEAkSOlYYjBKqowE+7a94RCyLegifNZfNP3c2tBHmDyKx0NPlP5ClZV5Gg
 vax5fGlFIv2QGJmMjznP88eo/x/PuFnrOk8/KM+Pd3bA4tC7LodhfzrQ5PcqnBI/cNL/XelnAP8
 kj7POirDs9ZzLwyWL2st6GAvzrX/qINFqIwnmNGn98zY6uaOhmWz/wR4pU2O9+kww6BYByzw6/k
 mov0nrzSS8nLnsovjI9h2ZU5vsxEBRvsqW0OtEHfLmM9ansNyPrrqQa4SoZ+rquRqCVI7ofqZi9
 CcGahd42swBx5ZUgMY8GU36+X58tQcPYH6tloHx72mZO1Y/p
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: sR-Xri8x_IGIt11DZ8ZGNAt453Vv7qcK
X-Authority-Analysis: v=2.4 cv=QOz91QLL c=1 sm=1 tr=0 ts=6ac7974a cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=VBylRfG56Bf4BZPIeVQA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfX90GxbayRRKtI
 E4MYC3Djo0a7huvDosjIWYq4rgqFc5l2afGv2H3zVD9+3V0CZS3uknfEgiQbRRRe/ONtbWQcOPW
 Q8dSQh92UNwcKrpl3l/rAuC1udXnMMY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfX4RIWRmYgTkyd
 VD+6xVz+HoXk7IVMnKRZxYY4HzfxdllH0Kd4osUndzNDI5WfgaXy0ckxZ8mvnIhZ8awpEA+yW+l
 a0NncgvIxgBRR4ls8Wjy9U+LmcrXx9CDtYMQReorAM73nUwjau/tiu2WMkFQSfLTXyBgcLkJQTT
 5x7HCJ6UIbP25Sj+uf7zH5ZB2Mi5lILubieywgLePlrn6/yJvqKYdjEjTw8o3/cyw9QhA3T6zPT
 Tm7nzrV2a3FRzrE/Sjuu+jPnoK2lTMP6cGnj4NOzw6g9GY4sRtN3+RtCujbT7IYIILFaNWDQov9
 ymCJJ/6Z0m3wSCl3ht57fKEsdmdAedXZyXcoMThEa+zipdGs8xuapSk2ow9VbcyqyD1I+t2j2tt
 UuAz3S2z4Rv/gaeHLayA1VQjrNrFV25p4ZvG4rwZ8s8U4VFOmBcq5RwWc02nOnkKr4cq/uPsyQi
 xB9xmdWFIC3+TT9T/gA==
X-Proofpoint-ORIG-GUID: sR-Xri8x_IGIt11DZ8ZGNAt453Vv7qcK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080052
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

Panel drivers don't have an atomic state and so they can't handle
additional data to be stored at the atomic_check time or to be retrieved
at the enable/disable time. For example, it prevents panel drivers from
supporting multiple display modes or making DSC being optional in a
clean way. Drivers like panel-novatek-nt35950, save the connector
pointer in get_modes() and later dereference
connector->state->crtc->state from prepare() without holding any locks.
The panels also have no way to reject the configuration they cann't
handle, as it doesn't take part in the atomic check.

The panel already embeds a drm_bridge, and the bridge has an atomic
state which is property handled. Subclass it to provide atomic state for
the panels. The callbacks can find the state of the other related
objects (e.g. CRTC state to get the display mode).

The atomic state is opt-in. A panel that doesn't implement the state
callbacks keeps working exactly as before, with the plain bridge state,
so there is no need to touch the existing drivers. The panels which do
implement them can only be driven through the embedded bridge, since
there is no commit to hand over when the host calls drm_panel_prepare()
and friends directly. Those entry points warn and refuse to handle such
panels. There are still a dozen of display drivers calling these
functions, and the panels used with them can not be converted until the
hosts are switched to the panel bridge.

The previous attempt by Val Packett <val@packett.cool> ([1]), but it had
issues with the API design, passing NULL for the state. This approach
follows closer the path that was chosen for drm_bridge conversion.

The series is marked as RFC as it is only compiled-tested only.

[1] https://lore.kernel.org/r/20260425001130.233935-1-val@packett.cool/

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (9):
      drm/bridge: terminate the lines of the bridge state dump
      drm/bridge: add atomic_print_state callback
      drm/bridge: drop the bridge pointer from drm_bridge_state
      drm/panel: add atomic state
      drm/panel: add atomic_check callback
      drm/panel: factor out the panel follower notifications
      drm/panel: add atomic variants of the enable and disable callbacks
      drm/panel: add atomic_print_state callback
      drm/panel: novatek-nt35950: use the atomic state to select the mode

 Documentation/gpu/drm-kms-helpers.rst         |   3 +
 drivers/gpu/drm/drm_atomic_state_helper.c     |   2 -
 drivers/gpu/drm/drm_bridge.c                  |  15 +-
 drivers/gpu/drm/drm_panel.c                   | 634 ++++++++++++++++++++++++--
 drivers/gpu/drm/panel/panel-novatek-nt35950.c | 159 +++++--
 include/drm/drm_atomic.h                      |   5 -
 include/drm/drm_bridge.h                      |   9 +
 include/drm/drm_panel.h                       | 190 ++++++++
 8 files changed, 915 insertions(+), 102 deletions(-)
---
base-commit: 5d7b464a4f517d1db533b1b231f42ddcf4e1dff4
change-id: 20261007-panel-atomic-state-05948a804545

Best regards,
--  
With best wishes
Dmitry

