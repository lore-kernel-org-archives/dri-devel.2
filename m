Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C464DFF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 17:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BBB910EC61;
	Tue, 28 Apr 2026 17:21:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hq8pIB9p";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zh4NjyHU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675DF10EC61
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 17:21:44 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SH0asO831095
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 17:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=xn9wqdSEMs33syKczrigyc
 4LqCkPv8AmhRyIXWRuaVg=; b=Hq8pIB9prRvOZD/7ftf72Zaz+7Dawl4GP7e2gv
 NHkgfA8DCa8v4YkHYW7qWGUWCT68vS6C+Upipl4hRf61kkfedLEvhwy21r8rK/Ih
 QaD9AY90txWWv4ME7yDaS5wE0KaTwqupwhTMW0VJ3Cc969LC0lZhQ3NR4R3i8pEI
 3Mv2Uvasf07LJyK4c+WekyA6xndp9dLzofmbalnMJJ+j0R2RtBB0+OEWYbnXg5Yv
 Gtb1hBYh8/Oj3Qdf1RYj4oMNr9ydjJiROH8xj/1RNNDWJ3W8M8q8AdDodl4QeH3o
 JfFG7JFgtgT5hnlhoF/MnVVjylVeUs2ANzS+AwJdfxvBBzWQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du0wq82ww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 17:21:43 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-56eeaefec9bso11708355e0c.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777396903; x=1778001703;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xn9wqdSEMs33syKczrigyc4LqCkPv8AmhRyIXWRuaVg=;
 b=Zh4NjyHURm0lf34ldzGskCH0P0I2dfzEqRrSb6tCWqd1PbgDYwyJiUDMuvK/QXCyfr
 C7p3148gJm9s153RxYcd9WvN2O3fwKvdNDmnttQs9ZoVl8852fVe2BI1SZG8gw9YDyeb
 cgEat7VMzgSNpv6wOoM5f5K3jzOFPks1h0yaPW+4sLqDtxKiiEKtaF9pgWrAWCOHvVLN
 t6Jrc9oWhTsEemWMnk9GQDfvFAHbkysz8vFfsXBGLGepR5CWJgWqAi1nkNdLXYXZVO1S
 yk+ipTQubnHodk4hwHywO1QgaqWrBxwZ+Mjtz8MUwEYHULx2MYN8R/lBQoUwZg0JUhT0
 ASCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777396903; x=1778001703;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xn9wqdSEMs33syKczrigyc4LqCkPv8AmhRyIXWRuaVg=;
 b=HLg4Gb6s+WZ3UGq/fhTn0CuYzvTe6YTvtbe7hUAB2NA+bs/XDfL595+XAPqp7CE6cr
 klZhQVUEAmrQcOvad9qxeWXuis37054lWB2juaU5IHuDmSHPs/kMv76aDEkHrEXxn49W
 CtzEYdovfdeF2ZfVqwGxbGT66zzw3k9H2LOyDB8DXsmKGmRa9lXXmNI4J3f9Nm02mVlO
 GOiimWWhjAxJvILaPUojV9HlQKH5HX/mVyUGaFHc921OaCY8QHd69LLiSt5nhErUUgyB
 3IKfrQ2YL4g8XPHxDMpUvRFvAG269XsEa6QoDdF7+OfFknZX2XCk73B3zWZ9NlZKSOw4
 b44g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Y/RMEtkOl3BY2PzOgW+/O4pHMSPS8YHpwPwSNwuiA8hebZjQMaQ3LzJvUXCJLjQRUmqxZCN8WbNY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/GU5W134nc7kF+BKsGMf2/pTGTyK4eBjb0yxJVuDbOfdqsy7R
 Qs99YyoGQ09n8Us33Gsq/sU5dxiwz8jMI+Tfd8xt+m9fm0nU5DiFlCYL9MRRj7jGsjvQN4Fzuww
 VbS4On41Jw+JyajtVTy1BX4kR8PhYHNHqJ60Q71Iix6BtOB+RVeSmn6LMJaBW1vCOsZxuWok=
X-Gm-Gg: AeBDieucoZyMKnVISRPUl0V2nuoEAwkl1oHdFZAFFctBqnsUq+EZqs4qHMtFsbnct55
 dntmsJE4yom3pNuTD6v8f8pJt16kEaNhPLl/EKspCJh3ZKAR3aoab9TJjKQtNU/GAANzjQ4d5O+
 E9dPF5oHNtD3aKD9qip5PLU63FW9K3OnAsqEfNbFwym0Lf+JI84SYzMNHvUNjck6MyxLFKhh29i
 k5DaulhbRCd4RP4se+qzF2n4LN7bpWdWq5pTyIME/hbIGd+VtDg+QK2jaArZcof2VF2E6JYICS/
 Pybt78jIhbbgDeoVtqYbJeoRB93uMJy3vztjBO8ExWzrvcefZ5t7BLZAn5WyKpCCMArI8rTglFl
 IP/6AGLR/O175TlgtBfjjc4X5zpxt2eBLuBD5l6qzg0ZzBNCgO3V+PaTtbMOcZDZ4Lv4Jj44vyu
 kimf5E1W8JFxyQm+NfsNjec6dBB8EG7DvxtQKAcp9z3VTiBg==
X-Received: by 2002:a05:6122:1d44:b0:56d:b4d1:3c3a with SMTP id
 71dfb90a1353d-573a530f08fmr2515051e0c.0.1777396902883; 
 Tue, 28 Apr 2026 10:21:42 -0700 (PDT)
X-Received: by 2002:a05:6122:1d44:b0:56d:b4d1:3c3a with SMTP id
 71dfb90a1353d-573a530f08fmr2515031e0c.0.1777396902255; 
 Tue, 28 Apr 2026 10:21:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3923f52e8b1sm8950271fa.23.2026.04.28.10.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 10:21:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 20:21:38 +0300
Subject: [PATCH] drm/msm/dsi: don't dump registers past the mapped region
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-msm-fix-dsi-dump-v1-1-5d4cb5ccfac7@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKHs8GkC/yXMQQqDMBCF4auEWXfARG3Fq5QuNDPaKSRKRosg3
 r2pLj8e799BOQkrtGaHxF9RmWKGvRnw7y6OjELZ4Ap3LyrXYNCAg2xIKkhrmNFWnh62r31ZMuT
 bnDjvZ/L5uqxr/2G//DtwHD/vbr1PdAAAAA==
X-Change-ID: 20260428-msm-fix-dsi-dump-14cd71b5c33e
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1589;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=5AJj5gyS32IvdocMHajacRucw/Mcc7Uzq6Gz+k1sSWk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp8OyjNONsypGXls+eo1YAT9pue1gJLCpD4mCfE
 FI++wCgWh2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafDsowAKCRCLPIo+Aiko
 1e6gB/9xe+C09T2JJBbS2bxIoXqB4T9B80/eImmquoUDc4l6N6VFEDPI8dQ0VyJfvLaUAMTXemy
 gW47ojNdlwVAKV7XsDy35ci8kiT4y7Pccmvn+GW8tZD7ihPHjD8EkR6ySMZmIIbrZCUq8d9RWhN
 dNxyBEdq/3F7NV7MwYSyhxgxQ/v1kuMSwZ1vpFQJa6+yHI9el1WMeCCnHFn12Z/Qtz+FqoIwKbp
 67E9Im9yLj8nWnFWpYU8bkxs0vBHQ/2/HSygXQG5QPln9xXJlLY73xf7RRn0eFFpwAR8l2fdkXQ
 8AGNBcNIechCM3HTh0c+v/7YScKfdLrBUkggL2MjweH0yaiR
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: FFaqkCEbLNFcSi6notoM68I0VA9Lb04_
X-Proofpoint-ORIG-GUID: FFaqkCEbLNFcSi6notoM68I0VA9Lb04_
X-Authority-Analysis: v=2.4 cv=BfDoFLt2 c=1 sm=1 tr=0 ts=69f0eca7 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=FcX7t0_lAfRerrM-ltEA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE2NyBTYWx0ZWRfXxzHkRpHH3X4S
 biIL1CmXw8T79OvoIts1Erkr7CiY/K8iaeI3BNZusHAlBCgH5qp5+z0CBekl+tHtQRt4QgTfZIU
 ogjtFoB8zLx0e+iotX96FCtuCTWQltjoKAWkRQ5X7s5E9alXGbgBkjE9pNQqkTO3xqVJugGwSH5
 5no+dZJYpntNCX4BI7+4/pq/Zw+i9NAmqT9l3WXmvmTSA+mBj+fFuwClwlzyns9yi0FXXFQkYOj
 Fiv57uRNs0iRvRYnjB7sL1OfJMgKT3j0Iif0K9jrA8/bJbVaLwPITsSgXVBTxQjW1cY1WUiieNC
 kyPhUG/b+EpnNwsbek+LLrOqqU8SJYp7bxTCgixMngdji+zFjCuBMKmqZaO9jGX7iiB7FL3wx78
 p5nYDh5/evI5RXT6VXwtf5vM2RAxPt3FGMUmtPgkYNDXWYgmzMQ3UGAlOhbB8DBl0NCASSfBOvN
 O9NL0kUIBrzsKLuvecw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280167
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

On DSI 6G platforms the IO address space is internally adjusted by
io_offset. Later this adjusted address might be used for memory dumping.
However the size that is used for memory dumping isn't adjusted to
account for the io_offset, leading to the potential access to the
unmapped region. Lower ctrl_size by the io_offset value to prevent
access past the mapped area.

 msm_disp_snapshot_add_block+0x1d4/0x3c8 [msm] (P)
 msm_dsi_host_snapshot+0x4c/0x78 [msm]
 msm_dsi_snapshot+0x28/0x50 [msm]
 msm_disp_snapshot_capture_state+0x74/0x140 [msm]
 msm_disp_snapshot_state_sync+0x60/0x90 [msm]
 _msm_disp_snapshot_work+0x30/0x90 [msm]
 kthread_worker_fn+0xdc/0x460
 kthread+0x120/0x140

Fixes: bac2c6a62ed9 ("drm/msm: get rid of msm_iomap_size")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 565d425f88b8..982abaaac00d 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -2033,6 +2033,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 
 	/* fixup base address by io offset */
 	msm_host->ctrl_base += cfg->io_offset;
+	msm_host->ctrl_size -= cfg->io_offset;
 
 	ret = devm_regulator_bulk_get_const(&pdev->dev, cfg->num_regulators,
 					    cfg->regulator_data,

---
base-commit: bee6ea30c48788e18348309f891ed8afbf7702ac
change-id: 20260428-msm-fix-dsi-dump-14cd71b5c33e

Best regards,
--  
With best wishes
Dmitry

