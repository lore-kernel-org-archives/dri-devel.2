Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9392ECA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8612810F9B0;
	Sat,  3 Oct 2026 00:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C0K4rj7c";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YX2xvb3p";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3407810E70F
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:03:09 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NeVXx3186872
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VyK0jJ9gcM0BdaaalrnnAAq4uZXo0yp3EptmyJF9IeI=; b=C0K4rj7c3yk/9m0Q
 whwlBeuvYuxmwuFzLoQ/RXDn11nrKRD1xQF7sJeUKNcDWOoAKAL9idWqa9SO+4gJ
 Q8N155BX1leEVofxidc255HePNPtCoQ6mPDJBTTHH/9wPa2qYKHtaX50xPpwH7Mn
 mYtarRolXaXkAMeL4wdNwXVVXH719+dlgc2GHbliJt3NfaeJmH65vU0FswIzYQcC
 q3hBfnL0E5lN7iG0ExBdyoPKpTAWtVEId08nTTyLYIpI6nEn4aGjuVoODSaz0Ehk
 e+3YAwQV7etggW+Xc6XFO4XsibMutoreivwFdZHp9+moivMyS05IewJJCMaUcJ1B
 lie3uA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh4t98-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:03:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cc5f70c8dso10292285a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790985787; x=1791590587;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VyK0jJ9gcM0BdaaalrnnAAq4uZXo0yp3EptmyJF9IeI=;
 b=YX2xvb3pO22Y60Y4enDTKvrH0D+MxRr6NQ3NKXoqkDUpSBf5aVr2GkRnQ40JFaiXD2
 9waSPBbnEh8amxo1wi193l58zqhIK/qP0NxWsmU9OKLdwOieqSpp40bLEyA+xCtBATle
 6TjZDg1h/06K+v1enCMJc8xyiZ7erq4+9E/8OuiwX2vyor7kQyzj8Q63FU+YjqrUuYiO
 MAPduafWGA5cS9HDVV9l1IDChbWTl6+6qIQedXI8u+1eKc7frgiHNpMtr3iD9x67uXz/
 4MyRfd9fGRXLgYX0176EX0GGdJLNcNtBetn8F3jqehQOVcvpdnWOqiRQB8GNmQfXWdXQ
 JRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790985787; x=1791590587;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VyK0jJ9gcM0BdaaalrnnAAq4uZXo0yp3EptmyJF9IeI=;
 b=CgLGtyR6ZkEPEcRhZeOOSBXyOq1vIdzleEH+uxJf9j7XHqMWG+YMtlz/dc7NzAqd6D
 rqVrpk5NpbAe0ucTgZOschD7+ovQoAF04ZMlcTBq+DZXIh243ROAj1My4d/9SJ+QU4yp
 RTnCgr2jhXZr8zKFesT3qzPmSYCKNKstQ5BySLDt/uaiaBz9+OwFYEq96wUPI/9hMxc5
 NALEwp6uckagLOe4IaZLADMeH+ISArfW0EE2s7smojIimT9TNqKY/dTS90ucl4SUbq91
 orzuaRoY05CPCpcEUeEMbzQAiasqyVMF6k4on8Y1vI8DqH/t3ARIuu4Z5iFJtCeM3v/9
 uzOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByE2WufRWRwJG87DeddNaEK9QLxPatal4PJCmODDeVpiKGTS2rzjylJxwlwzFZ+op+7p98BlPBt0rY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m6I4PCLCpz6njBYnKzINi0WcTepXRy+cqVuFLs/GXljBJAg85F
 rUqqXpEd+22MtebQsnIWcujA0NsU8IFC3+LBS+t5KjkKD7PwwvtnFZdYuGn2Way1btF7CXWGXXe
 ucGT/0/Q1OjRDLY0qI6q5LwyqVauNVDgHkUAVJM1RrLYxYI9+KSmVzR7ek7BOjKkiNHj9zRc=
X-Gm-Gg: AYBFou2NpCQe4TCO2bgi19mKbbXkPVECy/Wvw4COCKqg2hbfJR5/hLudbMNCGxM6GTG
 Yy0vYwQN9NDL3jR1WZh6SL9lbh1St5I2G8S/z+lMTZBMLxvvQzrMy3nzD/UfuMtnYdDbwlUeIA3
 Bs3G+ZPm+RDPZKtaClgk/TmiGSiBKk0u88RXa+lhpwPJ2g63HYrfH5AX81Wt90TaAXZXMZmV9M4
 WbV/N9nHWBxn9BCW+b2yithBrApxd3qKgf1XOsW1X0O6Gtqb+vP+K5MHrNat6qBspytx+XuEfmV
 8bt8ww31WdGcBkTVj9Ms5MNHknqUr6wbmOJInY6qG59dOFY+HSs7Czf1TqMa+A8Uh656ElAMx5Y
 nXTJP0A47V0KODmj7OYAJKrlkyFh4FYV1uWpfzsPGz0UzFaFUfMX147NiSJSiWgtiVwApF2gdzy
 yPKtHbK/oTkClP
X-Received: by 2002:a05:620a:459e:b0:93c:ba88:cd65 with SMTP id
 af79cd13be357-93e50e4a8e1mr195370885a.7.1790985787346; 
 Fri, 02 Oct 2026 17:03:07 -0700 (PDT)
X-Received: by 2002:a05:620a:459e:b0:93c:ba88:cd65 with SMTP id
 af79cd13be357-93e50e4a8e1mr195363585a.7.1790985786772; 
 Fri, 02 Oct 2026 17:03:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e2f7b4esm14234531fa.14.2026.10.02.17.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:03:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:03:01 +0300
Subject: [PATCH 3/5] drm/msm/dpu: assign the mixers to the CTLs per interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-dpu-quad-pipe-fixed-v1-3-6a6a00917b71@oss.qualcomm.com>
References: <20261003-dpu-quad-pipe-fixed-v1-0-6a6a00917b71@oss.qualcomm.com>
In-Reply-To: <20261003-dpu-quad-pipe-fixed-v1-0-6a6a00917b71@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jun Nie <jun.nie@linaro.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1494;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=2l3PQo2eShkqZe/3T8M+sGU7B8FyT9nkOEpNVRVu5Rw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEY079w/wHb9RhpVVW3RfbfHnFHNQ0fcCjDPp
 NDk9k1ceW6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBGNAAKCRCLPIo+Aiko
 1bE+B/9e/2Lri4CStNavGIBcLvzw6LYy9zVBZyF5O4q+8tnrC2FoTEYB4CmQv5h4gZrQK0I5Dn6
 zNHsXOHnAxSqsgZYBIyVsOQNfeWUMq2p4fWq10Pjr+hxbo9DpK8UKJYNMLoKDpoDIkvb6FTUz/H
 91gQj1maMQq6c72dd8LLsGE17SebG2MxoGfj+vaGswvZietDNyEhBLs+9I6ksMVwaWoEHduGR5f
 +Rr6M7wIvW5xV3CoU9P9OOhqp+jqSuxCojQwlNPnJsIcDg37qOCLznOUaEXgZl7aUBh7bMHPB4j
 BSDmdy59NIdTsZcplZkrUtbJ4Z3j4W+PwKw1L+YbTYoJundB
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA5NSBTYWx0ZWRfX5eIbhGTjoj0t
 byCQElkdrsWvhc7n0JP+jOSf08O6Tg8YZb18KLUONXF5IVRmIQ8x3rRQaRaZl7fTmSWTFWuCHwW
 ZZ/pg3Ir5/NziB0tj6a3f5kb2HbunN8=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6ac0463c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=vcdmnXjnQzLUmDnc4OUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA5NSBTYWx0ZWRfX+bE1ugRCOVFF
 ZaOBgiHZhP0B75OF5vC/pyOh14eu8/IgzUt1ImBBBVyHcTAQoyKupdLAMiDpndbwBD3fds0PqdD
 mTbM4vrMdqIGVCsfOTk+zATBpeK/MWGO0lMV6zgxyc9xYVYsEppuVYJriDm1gL6s2ZlBuB/ONDx
 zSAdj2DmDVKotmOdEMLg7GXoZbF9KZEXNA3M43dtfcDmhfhPm8THwXO3e2Ww/70Bnss7hcudVyv
 F/maAcecZyhv+GGCV4hx98z3x961UKYbcomNKyyXlLs/vgsXNPN/ZnBnB06Jjwzi+9YXJaBB9Og
 hU3Y7eZYOCnPaEmpog3IV72Ndt3rof9Cm0SiZSDPO1jY6lr8bW0/uPiCHqP0tU24JTTeRxVXecr
 szEkyJC1vwdn4m3VfX+8UEU9C+wsB1fAf7+8hpV2EeQbVrTKAjxZextMSDGbWRJqyhfALxOCncZ
 SavDWvmThYtbrjitlkg==
X-Proofpoint-GUID: 1QECqaTntDkZkywMurJItFqgZLzUCOZc
X-Proofpoint-ORIG-GUID: 1QECqaTntDkZkywMurJItFqgZLzUCOZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020095
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

On DPU < 5.0 each interface is driven by its own CTL, which has to
control all the mixers feeding that interface. However
dpu_crtc_assign_resources() gives a single mixer to each of the CTLs
but the last one, which gets all the remaining mixers. This works while
there is at most one mixer per interface, but it breaks with four mixers
driving two interfaces: the first CTL would get LM_0 only, while LM_1
would be programmed through the CTL of the second interface together
with LM_2 and LM_5, leaving the first interface with a half of its
picture.

Split the mixers evenly, so that each CTL gets the mixers of its
interface. Nothing changes for the existing topologies.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 828187f46eae..57f50a3cd9cf 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1469,7 +1469,7 @@ static int dpu_crtc_assign_resources(struct drm_crtc *crtc,
 						 ARRAY_SIZE(hw_dspp));
 
 	for (i = 0; i < num_lm; i++) {
-		int ctl_idx = (i < num_ctl) ? i : (num_ctl-1);
+		int ctl_idx = i * num_ctl / num_lm;
 
 		cstate->mixers[i].hw_lm = to_dpu_hw_mixer(hw_lm[i]);
 		cstate->mixers[i].lm_ctl = to_dpu_hw_ctl(hw_ctl[ctl_idx]);

-- 
2.47.3

