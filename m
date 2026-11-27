Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9E606A329
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JfV9vyPu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZiT9q6yR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AA2E112D83;
	Fri, 27 Nov 2026 20:16:12 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45391112D83
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:15:54 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJAvCj1127695
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=5gNzs6EANygMZK5ge43vpO
 x516Pj7m7kYw7rk2R+/3s=; b=JfV9vyPudrDx2Re24l9pRGmD6DeB+zU2fzjR5t
 oEWwTgUk5XBlMfnCO4nuy54wDyG5eOAyZv2eaIF/aBtese/jT9BlBZxTb24XXoWI
 NlcfdzbGWwzq5mZISUytpcXVw3WmIij0Dpvr7ko+9UCyN5DI9m9evKdZjNGVfG/p
 Elobrocs5/ENMgBaskuDtEPNMeWt74RYBf+dRqmBp1IHeGWYWkGhSTxxV9o/2yna
 3a1ROmp/9dKwWB9Yi2NGluowy+EXjWiDWKYzx2sHZmnr/ebZN58SvDsEr4pxwQhC
 TYkeCstOzxBNTmSqgl7jq5QZaCrfvRospcLyh0lA5h2eFPJg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74g6tu73-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:15:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so1521073585a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795810553; x=1796415353;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5gNzs6EANygMZK5ge43vpOx516Pj7m7kYw7rk2R+/3s=;
 b=ZiT9q6yRnFiv/59amnfWP13rBhnosyC4wHKVZYdRFpHV2GwAluvGo1u2INXBhn3i35
 cFUqYytqiDngEI036EAqd6vOJN/2iwJKnsPN9chI6L1hBm7fhNnJbeW3hA3vmmT9Noo7
 +3tFCV7/jWiU0DVViFYcYHSKsfMuMV7EmmJWjC0QEKYig6EFxodqw7F9uRfYAHyycw2I
 Nuwo/fbp/FAor6Zmjc8Icz+i1cSqJQasvlhR6/i1HMgSV/nAccx3CZorv2kVXO7lAo+c
 Y7J9OIm5zwlQ+FrhBiTWtWjp7wEQZq9fk9PppGkrp09y/3KaBKQk2rU6mhasLoYYaZ6i
 a6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795810553; x=1796415353;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5gNzs6EANygMZK5ge43vpOx516Pj7m7kYw7rk2R+/3s=;
 b=q/VI9zNZCnlpoDLDPX2deUTCYt+JxyjmmxMHFqx0h0DGjWJliosLIo4qs73crYbzW1
 qIAIhAvJXGzVzoUJJ+CLbBtFzmr1OKdkXYjPAl3toN/b2P8RnpmjtxsOlT67KKnkeAcq
 pMxFsABCrgrGkqqgJ+nR0z2q4xt3JFTmLiodp4wIe3OpWmZY9SYPz11qVOKb+ggQSN10
 u71+11UWVnqLDjsG/baTga20bLzV6QbKN37xa3LiALVoXFnS/w5HLhTSjr3MLtEod1dc
 S6KsyDtOLWu9zhjH+exCwfHhY+5Uw06ShyXbiiG5NheRxmnVz7lQklCuZH2fEsolJ9jB
 D+gg==
X-Forwarded-Encrypted: i=1;
 AL+hErEnt164P2sqdOd9rc8syniYv51SuqR//W4MvxE+lvAz4+hi8sJVLxi2l0oSSM/frlWxcPb+xtxSDrc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8mfQIZY2P6qvebJ+kh6tNZfqVXE8GnVUk1XokStOIvLYeurDq2
 j3B+qLK/cZM6ykVatKPpto1Xa6D5EZRsh3gwr00UNAxiaf/g121LJGJ7B85EhXFsyD0As0Azy+O
 eYSX7suBPIbDl9dmm5rvYb7kUAw+LTyKIAwFpT8On7SRKkfhEzSvosxwez5CiXHooyAXT4Vk=
X-Gm-Gg: AZFdTZdeniH/QB0ye6uD2ILxnyL7JUT28KOzNOJ3qxXU2PTRut9GOIWdVHoAuKEz+4I
 2+NBOZ5uRF/q8S9WvELJFfjTe4o5vtbGyqb+Dp1eV/eN8y+34D/f+Obp15/RD/FDLSK2xmbXuqm
 teI25h1c6uU9TNxP2Z7KhHrT42/edkZxKUAAcBNJwyfrp6Of7isRTaabdudm+nD4zFRTcoznouH
 QI4KxtGmuYwVImtRy7yKrgPQr5gb1UQjtWBZrvXNr96+hiwliHLIA3J8tu1ADMXjyhPmkGPrHXE
 0SyaCOexI/5hT1vd0G4m2EIbx88jN06yXxy4+l/NfJ+0POYAqPv/+bkQu+g1Kz6/Y17wEBhfgZf
 UziF9BqMN/IaraRM5pxELBtwag6YkmLC5FWeOXdE9y3XPIBFB3f4m5L/TlnNCYJmsqu2LMVCe+L
 9uG/8m5Y68y5Sa1ZmLxQcCtXaEEomQS8aMogm0xe7ViC3Np3VL4w4E89C9wXM6ww==
X-Received: by 2002:a05:620a:2956:b0:949:9cf0:badd with SMTP id
 af79cd13be357-949bab2f511mr4493873485a.73.1795810550276; 
 Fri, 27 Nov 2026 12:15:50 -0800 (PST)
X-Received: by 2002:a05:620a:2956:b0:949:9cf0:badd with SMTP id
 af79cd13be357-949bab2f511mr4493808685a.73.1795810544398; 
 Fri, 27 Nov 2026 12:15:44 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae8050fddfsm64591511fa.16.2026.11.27.12.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:15:42 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/3] drm/msm/a3xx: follow the msm-3.10 kgsl CP setup
Date: Fri, 27 Nov 2026 22:15:24 +0200
Message-Id: <20261127-a3xx-fix-me-v2-0-839408d293ed@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANzkCWsC/22NwQ6CMAyGX4X0bAkdkRhPvofhMLZOZoTJCgRDe
 HcHXu2hyZf/79cVhKNngWu2QuTZiw99AnXKwLS6fzB6mxhUoSpKg7pcFnR+wY6xcVRyZdiysZA
 u3pFTctju9Y9lap5sxl2xN1ovY4if491Me++/eSYs0F7InQtHjSa+BZF8mPTLhK7L04J627Yvs
 Wir1L8AAAA=
X-Change-ID: 20261111-a3xx-fix-me-bf13e6cedecd
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9u2J6T0zD+aRYytEaKwDgO4p8UYRuVHirQrfymlclSA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCeThc6JdlLTLoOb2UMIBzZKLjUDoTPdkeAM9H
 WiFuLL8TEOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawnk4QAKCRCLPIo+Aiko
 1VC0B/9h6hsIGfLVmQnnbkrKuIXaE2zGfHHJ4pycLV+JI20l2iQ4XDuXbCQXPP249Z65RZ0ji3o
 qOM0I7lhr7sKY0Z0ZEIz+PgBqkN4v1OqHdWtfnQzesod8IkOhNxAPCL+IyfgznNYVroNvopdTuE
 g7l2G0liQQnVJsNnMNi0VNeh/ANHY9HpFIG9Nts2ux5HYTHnnvTbbwUtEV3RUOAdTeS+p/8YlwI
 iMOKhyG7NUEPRNOBKt0Ki0zHvPqtRPpLowlyK1DK0BeVBmf+Law8RW2aMCiv1jhExd1wsnBiMsP
 FXuVMvyvodwi2QJRJ4p3vF3hRWjhvAZAMkx5Mf1MIWnNVsnz
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: VuDQbkuva1uSrUYW6SS3xm3BEzZsiedf
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b09e4f9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=QxjlNS_XKnkpB_o31RsA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX+8W9NtHh7eBS
 aiWfHz9Qol/RlhEN6YBvkFxxQyBOXC1BIDJpoLBmKCOkO7USFTH6dPBILr391dXIX8HabqEx1in
 lN3X+0dEN77O/prJZEG6AmC+c0eXY2c=
X-Proofpoint-GUID: VuDQbkuva1uSrUYW6SS3xm3BEzZsiedf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX21e/4UukzFm4
 9wn6qhn3+pq5PX1zXv71S5nZbfpIq0aiVSrk+5BdfEEOH/ceRBwjQ7O2PwuTNe7Fkd0ZNMEJjwf
 DxmPWUvDt59ymSs8/0QKckHxJuKkzUpCJ7cxci6clnJoOeK6R4FChABosiia1wnlUp/icbGHaoX
 864v2mhjJtTX0uJo/T5apD2TCyyMFh+TvmhbAdqdE0VZfqUj5/W9LW6eAF43OPp08oUscwhCNP0
 WFu8eUt6Lzu3drnIJOupnmvGt6+KtG4p524ofnDMHq93xzQf0gGKWxXRFoGEc6ZNKJxhgaHnuNI
 /5N1dSrriutDqKTS9Q5/6q46CpnXph+24axAi8GhKE0Yti7nN3AXiGlVypSA3I43UE5792+1sl/
 zlt0kDM9NJnZ6DSi7/R5VrL0b2WgxP6lLRVZSrh8DeoH9q50iPOIRwa3Ttk5zaNRL1BjC8AWhBr
 nBXvgz8RFkPsPEolDAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270080
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

The a3xx CP setup in msm still matches the msm-3.4 downstream driver,
and a3xx_irq() silently acks the CP error interrupts it enables, so a
CP error only shows up as a hangcheck timeout. Report those errors and
bring the register range table and the CP_ME_INIT data in line with the
msm-3.10 kgsl driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- decode CP_PROTECT_STATUS via register-XML bitfields, not open-coded masks (Konrad, Rob)
- Link to v1: https://patch.msgid.link/20261111-a3xx-fix-me-v1-0-d81f50f1ba1e@oss.qualcomm.com

---
Dmitry Baryshkov (3):
      drm/msm/a3xx: report CP protected mode faults
      drm/msm/a3xx: update the CP protected register ranges
      drm/msm/a3xx: update the CP_ME_INIT data to msm-3.10

 drivers/gpu/drm/msm/adreno/a3xx_gpu.c         | 32 ++++++++++++++++++---------
 drivers/gpu/drm/msm/registers/adreno/a3xx.xml |  5 ++++-
 2 files changed, 25 insertions(+), 12 deletions(-)
---
base-commit: bbfe1d58f42ad2cb56a01f5717355901698075e4
change-id: 20261111-a3xx-fix-me-bf13e6cedecd

Best regards,
--  
With best wishes
Dmitry

