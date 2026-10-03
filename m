Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32303CA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8660C10FA6D;
	Sat,  3 Oct 2026 00:30:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CNC5KUgg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BLjtIhaS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C14BE10FA6B
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:30:36 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NelhJ3338223
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /LAeqwoWtFqbSPLKUF9sSDQ0qIlLUHbHNTMbGdBh9Qk=; b=CNC5KUgg3fx7A0Z7
 +hHpEBvxYuCPWD+0hPdq+4nISUSuTRsjpFas9BZtvfpGvEaMqzAtFb5lV/N6DX8j
 COg2iDsemtuFfteOTUYypEs2u7UBJ6RLEzm5cnEmpyL1SO9N1Ju3sRSeKhMAJl6B
 X2jkUntbbgVN4HEDPFQ9obq0CV4cAk0FQqRC65nb+zfIRfaUzee5Hz5W7ZQS8Zas
 T/JDl+gvZg3ZdM8nM+9Nhsv8QjhEbgC7A+z0FyWkfYw3TkjVglMLA1Jsy+PF6s4G
 J7lmE0+yxEyyNv6HJSh19MeZrNydzCQPUoGYEQCmjt3XbImtNg914TL4oUH+06Q0
 yxE/6w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2aj033b9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:30:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e4c03d1d9so15421085a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987435; x=1791592235;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/LAeqwoWtFqbSPLKUF9sSDQ0qIlLUHbHNTMbGdBh9Qk=;
 b=BLjtIhaS3PjqV3Xr5CCbaH0A/biKIfPiZfefR2YWy+Bvbzh7uiyAkwON6hcj2Yvbbs
 0J9PXd5X/1tYJ7LX/KoBeVX0OXmdeOg4QL3U8u5Z0mX0ti8TUG6KFTNHvGl8AZOaUOMS
 4zAQvTfSytUMXtOPjnJibIkh9v6rHkj8wzRqd4oUn0vndqwW76YYVqELQkio9M+lVrrG
 VYm1/HdtvzqZ688tFSBvJUJfP+Mqc1AuNh1/ZdCMT2ns56kmQA8lIoC33w5UgtGlWyFD
 As0vyah1BikgfQ9IHBbwyFQCaJ2amBKsm4eCejBsDbtg/N8Mg/ftdZg5glK/Vug7z36W
 0U+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987435; x=1791592235;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/LAeqwoWtFqbSPLKUF9sSDQ0qIlLUHbHNTMbGdBh9Qk=;
 b=nzQW4/tKkq84mWPPr+Qua8ATcPk2WAoErcBHuo3lJ+5Groq6tslihPlT8+nzmLmZxb
 H2xCEorYIdRfxwuTnp/6T6gOlrxNJcyG2x70HTSCpd6maXiZLRZ0Uo3dHg3jrYd59As5
 7KRb9053LCjXh3ALxmBRXjUmmEWYjSL6cHGfPWC/EB4GJWiHiAR/qSn6GYPN7WMkt3h6
 9PoFWWSPV2LF1BYYDH67r/z7ZdkwIbKXlAl8deAzvN23VqaZyPwFmwknENwcA8LDhoqO
 a4+w9t4F19qEJOPRxVvh/bArXULaTlunqe3uCNyDOSUvA7lwFNrVSBXq2RnD50KFVOvW
 Fo7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxX7JTCNHlj7sRcEyJkAwea0PSQSenk+Mwhj3YtRF+jK/kAmiacrTzNYhQ1qH6xUwYvCQjXqKaTfQU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mIy2/RECnMJZADlHYW9VwH/EVI2IXbyoB2SM9G1peI4VUDiyfB
 qDe40jot+FoZbKXqw4kWHPbha2LKSoQbGMGVJqzB3RAcsKw2WxVy6+iRDWr2AwX3/eBa24bBlfB
 uNxcvcrgqtfw3z1Rs92AmVKjfWTXFyo1GyDbla9CBcKhHwZckbL5jj5CsEwvlCP9R27H2k9PbkD
 3bWco=
X-Gm-Gg: AYBFou19grblEk9n2uUZ2ufiIrJd5df/QRK81tmnEy8m8TBGMLeM8mhoyvoFr8hvske
 1UeCLpNCmD6iFITIp+9YqmY+nwdIfK1g1KFvW2/vKwUIfTqw9R4vXChZ4DMwfXjnSoH0AE6z8+s
 BJZdG/3Qj2E2DB7q7CVZqFo5wh4Y8OxOdDb52AAqBKlUbFQbU70tf8dhjWV0A4ZyS/U6fmZnpj2
 tHYuWD4RLLprTrqNLpZUgaEgoBZBxRosSxmaHCuk3uHnL0/RQ5yh5A+ZoHf7/YdUwGrYNGXPnNP
 hAUs5LHz1+cf5Bs8Yn/cAnhh1z6A89KtJGh5hbWon6kV7TCxarDFVg+j7wcrkaP5nNvFn5sD3UR
 MRSw9mzd2rU+6zxCXqSZNhIKQB3K/UZ1wuyGCAhdzK7bJlMi4DwMo4VRiHhPAngoZh5W46ZxWn4
 RFbNjhr26skSOp
X-Received: by 2002:a05:620a:7017:b0:93c:6e1d:96af with SMTP id
 af79cd13be357-93cf18b5676mr821632585a.49.1790987435162; 
 Fri, 02 Oct 2026 17:30:35 -0700 (PDT)
X-Received: by 2002:a05:620a:7017:b0:93c:6e1d:96af with SMTP id
 af79cd13be357-93cf18b5676mr821627985a.49.1790987434697; 
 Fri, 02 Oct 2026 17:30:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c7957d0sm1133979e87.31.2026.10.02.17.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:30:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:30:19 +0300
Subject: [PATCH v4 04/10] drm/msm/mdp5: flush the interface before starting
 the timing engine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-fd-kms-fix-smmu-v4-4-2a44d4d8ac77@oss.qualcomm.com>
References: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
In-Reply-To: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=GGiCoTigCncSjQExhHlehqh6DW7zeUi0eG81bX9nqSY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEydEynMF+CREcOokKOoCJr7eUmaLWS9JqE6d
 CaNTF0/C52JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBMnQAKCRCLPIo+Aiko
 1bsBB/9Usie+QA+ncwjkvmJl7/35DiD3s+wpkPAZT3Sbw3UIiyVxWeJoKeY1D/G2GNtFJu9FrjU
 EAUnso4T3Q9s9V9yKkJg0jhjIG2MUzP7kBo/V9LvPLSWoc2el1kVOMj4+H/LSLxCxP+zbbMPds/
 P7ZAWBh3T+tMLYYNEyPmNTUOo1bUGghVikMSsecG5yIRRyqZuim+GkFdUjLfwdZFPR20pPBdp80
 mwXYk03hTNAy+0Bx3jbadpTGpoVf19cLc5MuwJgpdHkGD2QUUu8Uw/qT81z8FJZEA0NecXA+9Sc
 yvqJKMcz4XJP6quXt5VYbNcyOHuJDks3ud/PZVp9+a6fFVzP
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX8REC5wXs0Vh9
 yHqxSy/oe1y9Qj883N4jqt6XhePUgnJUmey3JXM+DSoS3weTnLbILU49uv4eK7RSZT78IQZ552S
 HEBEFjSvHkXLhfs1JbgH2V41At3rUtM=
X-Proofpoint-GUID: Ewz0Aky36En-mjVbv8Rlxd6zI2AsVFNq
X-Authority-Analysis: v=2.4 cv=UJZIjyfy c=1 sm=1 tr=0 ts=6ac04cab cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=H8EOZ7U-Vh7qnyOv3DwA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX5vU67/1R3yoD
 3WGqUzgUi/ymqq9xD5g6nroEivbp4S+rCcamYyYepXklrNF5CjUM4Dnp+IKcjy5Os43uYAwJEff
 G6drqOW9dhuMzdDsoqqcwrbx8ii7kcSe9iJo5HVuJxDjYR9bfNXWSE9Chp9OpZjfukiisyASYzY
 4PQpPu7IreIGNjN8QWK2w6uIqV5oAkgmU736elVBwcPVZQz5VF98pOkcwo2gIXNuu4Bt2688mo6
 jY/Rg96lbuage41jjoMb/QUBNVx5xtyTAPYaH+Oo7S9ptZd4YghOFaLzpfMC2nTobUqFEKfqf4j
 S7c7lD7dTyjfQZLctAHycoN3tEkzzQ8IrhlfwW8zHbdIl3ff7xwORYe2QUxFRVZvFbNmKMDIxoO
 3r6Z99Jg+UXlyPMI7oIlObn8jrUmZNbdVff3rqYBxt+0LJpIKUHPL0bOLwkqlMOGcNi0OEVe0BU
 C+SXlqXW6Bf89eYyZkQ==
X-Proofpoint-ORIG-GUID: Ewz0Aky36En-mjVbv8Rlxd6zI2AsVFNq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030001
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

Disabling a CRTC and then enabling it again can produce an SMMU fault on
MSM8996 as soon as the timing engine restarts, e.g. when fbcon takes over
after kms_atomic:

  arm-smmu d00000.iommu: Unhandled context fault: fsr=0x402, iova=0x01fa6e00

The faulting address is inside the framebuffer that was scanned out
before the disable, which has been released since. The pipes keep that
address latched (CURRENT_SRC0_ADDR still points to the released buffer)
because the plane removal flushed after the timing engine stopped never
takes effect. On the next enable the pipes are programmed and flushed
before the encoder is enabled, but that flush doesn't include the
interface: the encoder enables the timing engine first and only then
flushes the INTF. The first frame is fetched with the latched pipe
configuration, from the released buffer.

Flush the interface before enabling the timing engine, the order used by
both the DPU driver and the downstream mdss driver. With the INTF flush
pending, the whole pending flush takes effect when the timing engine
starts and the first frame is fetched with the new configuration.

Fixes: 06c0dd96bfbb ("drm/msm: add mdp5/apq8x74")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
index eaba3b2d73b5..e9eb1db92775 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
@@ -164,10 +164,11 @@ static void mdp5_vid_encoder_enable(struct drm_encoder *encoder)
 	if (WARN_ON(mdp5_encoder->enabled))
 		return;
 
+	/* the pipes fetch the first frame with stale addresses otherwise */
+	mdp5_ctl_commit(ctl, pipeline, mdp_ctl_flush_mask_encoder(intf), true);
 	spin_lock_irqsave(&mdp5_encoder->intf_lock, flags);
 	mdp5_write(mdp5_kms, REG_MDP5_INTF_TIMING_ENGINE_EN(intfn), 1);
 	spin_unlock_irqrestore(&mdp5_encoder->intf_lock, flags);
-	mdp5_ctl_commit(ctl, pipeline, mdp_ctl_flush_mask_encoder(intf), true);
 
 	mdp5_ctl_set_encoder_state(ctl, pipeline, true);
 

-- 
2.47.3

