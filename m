Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630E1606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fRi4HTDc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eu9XDbjo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F94112D59;
	Fri, 27 Nov 2026 19:46:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2588310E816
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:20 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJB3Xm3752913
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VcCsLT5EX6aB3PHtyFEtlY0PfXB2HfC+KFbRCcp0Iwg=; b=fRi4HTDcbHTygF34
 W/L3K4HEOYfYrqyS8blnGMP4Ums0IO7H0quwkyJMkBNW5xqvSFgfCsnfAxbCPGwd
 r6qehQeERgVPL1D06i1dmOxMjKmG6XkFa4+e0boAIyQYjz3efydkbwFYy6xYFnrU
 MGR3Yiujxmpg9NR2EIkDpRGO5q80a20/O4xbvJniZcZs7XPmXSJO5Gu/ziT1FTK2
 2AzDCNKJebfww0QrtIQLLXAR7MAqQUdZA4VJEpa9s7QMQ4oyDfEmLUIrO/SJ5hq4
 g1+8SkTFZ9I9GQwpCNMDE1ZpNkPfhI+Rl9LQi65BC9Xll+MTNcSN9bBo+/gE2ed7
 cTTlUQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74ghapp6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94961ed97d6so1382382385a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795808718; x=1796413518;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VcCsLT5EX6aB3PHtyFEtlY0PfXB2HfC+KFbRCcp0Iwg=;
 b=eu9XDbjoZ0IZw7n3uKA7DeCYTdBdMjOcwFQCkuV0iHWgWs9vmM571MALBpHuNAc4wG
 ynAmAWGAVgRYADugA8q6p006EJ77vkrACCVdeIusjxhUbLQq4PH18EC0HuyCsZyIvRjR
 I9rXADKGMp94iXbExSX8ovr5+9oyCavHVu66Mw+Hfx/RTtRoIlVfVPpMxMhL6EfjoBCF
 zebAmANzql835RrHqp7ctHT+H2reCzBCYOYhCAgFpvyk2DVecd9t89ombQU4d8wcuaN4
 S/aYukxNlnzjW/Z1wdJtqe3bGehF8vOLVYjs0MFtcuLIUpz/d/580+EQY2gGZvWyBfx2
 lZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808718; x=1796413518;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VcCsLT5EX6aB3PHtyFEtlY0PfXB2HfC+KFbRCcp0Iwg=;
 b=2Ns0sOApc+WZLL7fOqbfs14/iJvtFJbXcT5nWnhtNo7y/v5ShZvy59Ags6yij3Lg2A
 aHpI0z1dolLgE5kyVEo5EdCk9ZReyjRYrO6QQuLShvS5bxK8QOfg7ByGBs70gIYjwbNw
 i2rFEwB7h8YMozSaSj/gMz/X7rD1k/dgCZLdeSZ7s1Iybg4PaARIRZRjqKNljwSSxKjN
 WnVw87SAi1b+jRzXmbSorCQSpZ6G8Ys6AUlwBWhQYowLsyBqHtKFmm20NdGHwbNUWCca
 9B8kMI41bu4BlDr7brCAhD5rhK44AjmawIkGJPhVmrVz9aX8dFCAg4aqMN9X+fP39KUS
 G8WQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEK2eoq/TILRZTw60SMqvQ2Y79MfI+bwsNMyqG5+rgyvON9l2npu10DlA2Sa1fnrNOewcRajlbS6cc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9CtHRxnyCZqDBe2u+eCYPNRbKgP46K1voznKOCc3GqDC7z3jGz
 lMlhWnIuSrb85mOSCeAlR0OXDU4QxWIlZVJ7e0mqbEH1IoyJSj39Em0fwpK/x48oWXuWrrf3gY2
 PsM6HsKTes+98qorOyXMDfRx40WiiFhL9aKdWwJ3F0OJHgUvAV/OTFwSkli7vLq9/7bvg1v8=
X-Gm-Gg: AZFdTZcTDpuMXG+ze4uorvgwtpGXFZcNfh/BkD65y6rMPyYd87dFonqdZnX5ax20MXn
 0CXMGP8rhL8AdarOMdQJF5zoViqyehSw5s1lBK/dqta2HCKBy6qtBpFrlYqV7FJgZZk5yD9uQfr
 j2kzao3Ao8zjHDbTMi9sFzfR9eBXxKJFEwt7AsdpRm8j3u6olOuankqdHLV72wEYy2ouJ1jPmoG
 Kr0jFYMwdEfaAiweGxhoVR0yA2ziCr+D/CI7yDseFpHr2gs7D/yJPbZ07+wrhcXsZFcAGqKMTlL
 nXwqBt6UzK4X40DRLK8lXGRgYZNK3B/AYXIrEnk4Rj+xYpGL3IS1Ho+mIG4WMboPTmiQMbBXJ3M
 az93Chl5t2hQjQFanNI8pQPfqIQ6iF26UUdRN2vcpKJhWVJ+VCNDsjOkhx60wLZak62eNk/m1V+
 oxhDsp6/CcAkOzeY9xSwMmScT+4QFWWjx7YzW8ChfGdYMo6VLBt3uM5DqswNDaaQ==
X-Received: by 2002:a05:620a:4625:b0:949:5c18:5347 with SMTP id
 af79cd13be357-949b340227dmr4689122685a.6.1795808715701; 
 Fri, 27 Nov 2026 11:45:15 -0800 (PST)
X-Received: by 2002:a05:620a:4625:b0:949:5c18:5347 with SMTP id
 af79cd13be357-949b340227dmr4689109185a.6.1795808714898; 
 Fri, 27 Nov 2026 11:45:14 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae805575b5sm59655571fa.34.2026.11.27.11.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:45:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 21:44:27 +0200
Subject: [PATCH v4 14/14] drm/msm: drop the runtime PM flags from the KMS
 teardown
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-msm-kms-destroy-fixes-v4-14-242b0a3f8e47@oss.qualcomm.com>
References: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
In-Reply-To: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4805;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=T+l+RL7AsJ3F3YWiD7R3hoQk39AscE23oG7jEwbc25M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCd2vARugP2tvnxr2rc+ruB6k9VsjK6Pl5sYKl
 CjHpVnKpsKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawndrwAKCRCLPIo+Aiko
 1eBVCACk8vdqshMkeLsVlqOmrLsja6i3sQOjQCZHRMfD8paTkpDklFV59QKRhgio6q+B0JxK6Zh
 cfj10qdNejzryjMlqkZ21WKV8U9hRBAjfxn/Ay7cYOxYT52XOqCbtEBBLBw7MV38HpXeVaXUEBz
 cN71DaBIVmn0POT/3vfGAfZ+L5CQLq2Ex2PjJ6XdmK+2KGNq65X1J0m6p0RTuSfrTMsiOf9vg3Z
 F2uyle2IjYp7OjHThoni4HZJ6uUE3edoY/wdJ/Pw+fiNfUfAzBD02r2Zne1wOAgY1E33g2kc3Up
 8ERB2C+fwhcFpK7lGZtA+r4+Iqbv14sWkRmpYQJZ6DvsVG6p
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX9EZe04tRRDpA
 Uz7hk08vRjLjvumzbSZvJ02SnBlAieSs3dV6YGbrldLb19er7FHKTmiRS/ZmqSQpf5WNdu+9sqP
 sNCcAwaEgYCTwq5o9O8cSiSrfmbc29o=
X-Proofpoint-GUID: TXT8jdC8AgvnNYzBvbzvTOIutT4DZOrf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX1sMCi9XOxJc9
 9mYrUuzPb7pcJHWhiRi2eVshOjVNAiFpByZQ6SlXIIWOdCoQzt9kletFqkLvCKHiLId/i4pnDkF
 0LQH8quCya95pdIp8PBLzLdtE4iAT3GbDMAQz4pkU+HxrMKw2rqUAzxs27iAxQzv0z02CngWBWT
 UkXuMBJXoJmgko0r5opQSLVH5souZj3A7bo3tS0BQAvSW0fazAD4e8DuMhmxxB2Er6+8Ra5k1JO
 Ui3ToJM4LSYAc+eXx8PjHCznot1EREkLwC8sRfmVpiH0yKv/jAjJAI9F/771+M1LMHq8Dg++CWc
 M6ry01QrKyJKqlDZWfnjlyQN6ekbPuJDCxBzl0+puvDnG6STVFO7HboyHTceXQNotOBU8DFb/p5
 AN8wae9QYekMNin6qqwuLyR0TLKeuOERI6N5GKwJW4fZ2O03xAp6LmddTQCSGrgJ6fjNSae4Umt
 TpZNc29jE1rNcy5U3nw==
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b09ddcf cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Yohvr2p7PhcuVfY586MA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: TXT8jdC8AgvnNYzBvbzvTOIutT4DZOrf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270078
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

The DPU, MDP4 and MDP5 drivers track whether they have enabled runtime PM,
and MDP4 whether it has pinned its blank cursor, so that ->destroy() can
tear down a KMS whose init failed half way. ->destroy() now only runs for
a KMS which was initialised successfully, where both are always true.

Drop the flags and the checks.

Assisted-by: LLM
Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  | 4 +---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h  | 1 -
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 7 ++-----
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h | 2 --
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 5 +----
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h | 2 --
 6 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 3546efacba3c..e994fd267c5b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -927,8 +927,7 @@ static void dpu_kms_destroy(struct msm_kms *kms)
 
 	msm_kms_destroy(&dpu_kms->base);
 
-	if (dpu_kms->rpm_enabled)
-		pm_runtime_disable(&dpu_kms->pdev->dev);
+	pm_runtime_disable(&dpu_kms->pdev->dev);
 }
 
 static int dpu_irq_postinstall(struct msm_kms *kms)
@@ -1320,7 +1319,6 @@ static int dpu_kms_init(struct drm_device *ddev)
 	dpu_kms->dev = ddev;
 
 	pm_runtime_enable(&pdev->dev);
-	dpu_kms->rpm_enabled = true;
 
 	ret = dpu_kms_hw_init(dpu_kms);
 	if (ret)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index e39831a397b1..769b8ce6332f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -87,7 +87,6 @@ struct dpu_kms {
 	bool has_danger_ctrl;
 
 	struct platform_device *pdev;
-	bool rpm_enabled;
 
 	struct clk_bulk_data *clocks;
 	size_t num_clocks;
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index cb95a492e070..8b07881c3f8d 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -143,14 +143,12 @@ static void mdp4_destroy(struct msm_kms *kms)
 	struct mdp4_kms *mdp4_kms = to_mdp4_kms(to_mdp_kms(kms));
 	struct device *dev = mdp4_kms->dev->dev;
 
-	if (mdp4_kms->blank_cursor_iova)
-		msm_gem_unpin_iova(mdp4_kms->blank_cursor_bo, kms->vm);
+	msm_gem_unpin_iova(mdp4_kms->blank_cursor_bo, kms->vm);
 	drm_gem_object_put(mdp4_kms->blank_cursor_bo);
 
 	mdp4_destroy_vm(kms);
 
-	if (mdp4_kms->rpm_enabled)
-		pm_runtime_disable(dev);
+	pm_runtime_disable(dev);
 
 	if (mdp4_kms->vdd)
 		regulator_disable(mdp4_kms->vdd);
@@ -451,7 +449,6 @@ static int mdp4_kms_init(struct drm_device *dev)
 	}
 
 	pm_runtime_enable(dev->dev);
-	mdp4_kms->rpm_enabled = true;
 
 	/* make sure things are off before attaching iommu (bootloader could
 	 * have left things on, in which case we'll start getting faults if
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
index 06458d4ee48c..9dd829ec9401 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
@@ -34,8 +34,6 @@ struct mdp4_kms {
 
 	struct mdp_irq error_handler;
 
-	bool rpm_enabled;
-
 	/* empty/blank cursor bo to use when cursor is "disabled" */
 	struct drm_gem_object *blank_cursor_bo;
 	uint64_t blank_cursor_iova;
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index c349eedd55a6..bbf459bff35d 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -575,9 +575,7 @@ static int mdp5_kms_init(struct drm_device *dev)
 
 static void mdp5_destroy(struct mdp5_kms *mdp5_kms)
 {
-	if (mdp5_kms->rpm_enabled)
-		pm_runtime_disable(&mdp5_kms->pdev->dev);
-
+	pm_runtime_disable(&mdp5_kms->pdev->dev);
 	drm_atomic_private_obj_fini(&mdp5_kms->glob_state);
 
 	mdp5_kms->num_hwpipes = 0;
@@ -734,7 +732,6 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
 	clk_set_rate(mdp5_kms->core_clk, 200000000);
 
 	pm_runtime_enable(&pdev->dev);
-	mdp5_kms->rpm_enabled = true;
 
 	read_mdp_hw_revision(mdp5_kms, &major, &minor);
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
index 7bf2172fce0b..c0b163c4baa3 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
@@ -62,8 +62,6 @@ struct mdp5_kms {
 	 */
 	spinlock_t resource_lock;
 
-	bool rpm_enabled;
-
 	struct mdp_irq error_handler;
 
 	int enable_count;

-- 
2.47.3

