Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6FA606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YWFXi1wx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XU+K36Ih
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE82D10FC43;
	Wed, 18 Nov 2026 13:08:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50DDF10FC49
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:08:47 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AICLVZZ1178516
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OYcelcE9NXTnlvzeVzCO4FDv0oUoY1w29M+7qaD5s70=; b=YWFXi1wxS+vbqpTj
 KG9gOoTj9JIX4wK6B8Chm0WCtMeN1Bx5vyYI/Y8ODwe20CeRlROPJwi2W0OB9tl/
 icm3c4DIs+9oiThj3z0z+t9HsDKCpiPVmgF3PO5Yw95NI0G2lOEKPsKCfmAvxj37
 /49nmHKI3VSSf2wQM81dCt9Vx727JxOF8o1AV8i0vnZ4hLqRrUX0exwSPqulHxyl
 NeNkVNyvQlPFd7h9sHdVuszDhjvVZkK3wt2fO1HLstUdjt5DXKHMfZ2/PNj9RRbH
 Z4LRQCG2fsuEsTM0cec6JJQYOspPR0MAD2oOabqi7UcMoGMOrmJf8gOoFouQ5cuL
 NcK+cw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvck3qt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:08:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cdb53f8aab8so96333a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 05:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795007325; x=1795612125;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OYcelcE9NXTnlvzeVzCO4FDv0oUoY1w29M+7qaD5s70=;
 b=XU+K36IhM4WLghpO6YX5JhvFWp7CHRit6tBe5/aqRS17jTdK2DcSyevSwFRQOWO77f
 xBWDcu7B6fT/r7teYOAcwryBhrOW0kyu+mG79d1I6s0f5fqPUNMNC5Q5Haq7fIVCJ+EI
 OxBQKZnHLea0DDImzV+6K8fSgBQGAEdO3JQE+3cIU9l8InrPVzgFjtiQjuE6EQm8B5wL
 ECz8YJS5IGeTHq8Ap7o8ak2EasiFd1msGNaYK7Jly9xfumkzX7/pHJGI83lwt4BHxryU
 Hzk/sFlBcHD45miy+DwZtQrp+B3iS7CBw+B8OrLwSbQQPVkwzpsg8KaGiokxgakHC3vx
 nD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795007325; x=1795612125;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OYcelcE9NXTnlvzeVzCO4FDv0oUoY1w29M+7qaD5s70=;
 b=nbIsuQUoG/9+SvdjbA9Y+JaNntqKUgF9g+PvqEuoVnqie7G/0LzpdD2WptpGJPZiz/
 QzjccjtBcQ96lnDFCjui6Vr7MT96/3R0FBjlCa1VjlyiYQg3ZVdskxGdpnu5qQtsDDTI
 VrjkBJibDKOnqGOYAjv0ypfyqIRNmYMKf6fOqyPuvC+1LVp6irf9TsTvuPcTXa6nIxHj
 QNsw7gFAwiAGfsAPgPW2fod+FxZcn8LV8k6PkDLOT1dm+HxvVeH4MdJ8kYUfH1+6pMDN
 pD1rkY3tA+93ulelHBVJpHU/ys2gU6FOHfWsASOahS+8e9kqCEflLUjGH5JqOCnXCoRQ
 5U/Q==
X-Forwarded-Encrypted: i=1;
 AL+hErH1HXVxqv0edB8JAX3LWzhaeG+6uWe82FyGuSeMsUBQlYgk0Bc2x09WT/NL9DHUT7QB0ObviNLJh3I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9t5ab69z7ST8lVPI8DC4XoPtkqd0j0shQWLXcY/qwzDwusswv9
 vZpUJ+hHj7OP/EkTlzL54CPfpdkhb5RgYzp/o71lVTuTnOpqQK/OUpC34MW0RGcE6YHS9RDKyIY
 D1vktd6C4OrBeucZ5EkznbevHgOFiUiUuPn39pwkdLmEr93MlIcuW2UUzfYTE5bR0rTtAURk=
X-Gm-Gg: AZFdTZfrvTBzsLG8I2kA2tKVIChyoXTh8I5kYfJapHeYRgT9YDMbf7QinXIiDjTq1KJ
 n6Ty5YtgNziuegGQcx7qwhoPzBnFiaIuj8s9/JJiZt8zKyprvlu1Nd6bE6tgZyUQux13ke6jIpq
 gTswBK/r2TzdYtOgCCwjcJaVEvDpG66imjzvoOpiKEhYNgL2eVIIIil3TPrOtsyNq3bP4QoTkMo
 gbPMo0gGlZZsjk54FM7BawLrtu5TmiBCGZhKwI5C/urc1I6rbQb+0oDf+S4XUH3Mz4dZrKLEd/8
 0+YrROFxPpJNM7950RDvJpAqV6FKIZ6hXZF1CK8VwlbQKEpZZj8BQZK8YqLFWhQFIEWMO0L6Usw
 SioahUZYUpG2Z6F+oTy4FdS09SQUgzNc0/92Gpxl27jWC3zcc/2fz1fEFRzSkpAPIxgY540SQdH
 T2LcGEqpLf
X-Received: by 2002:a17:90b:3b86:b0:3ac:9e5e:d1a5 with SMTP id
 98e67ed59e1d1-3b3d083c92bmr4657122a91.6.1795007324965; 
 Wed, 18 Nov 2026 05:08:44 -0800 (PST)
X-Received: by 2002:a17:90b:3b86:b0:3ac:9e5e:d1a5 with SMTP id
 98e67ed59e1d1-3b3d083c92bmr4657045a91.6.1795007324474; 
 Wed, 18 Nov 2026 05:08:44 -0800 (PST)
Received: from hu-pvgtejas-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d187dc82sm4909533a91.6.2026.11.18.05.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 05:08:44 -0800 (PST)
From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 18:38:25 +0530
Subject: [PATCH 1/6] firmware: qcom: scm: Add
 qcom_scm_gpu_init_regs_is_available()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-adreno-scm-fallback-v1-1-e99cdbf3121d@oss.qualcomm.com>
References: <20261118-adreno-scm-fallback-v1-0-e99cdbf3121d@oss.qualcomm.com>
In-Reply-To: <20261118-adreno-scm-fallback-v1-0-e99cdbf3121d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795007310; l=1903;
 i=puranam.tejaswi@oss.qualcomm.com; s=20261118; h=from:subject:message-id;
 bh=36QhktHN5brrd6bKAbxnZZKZPlIcq3IKQTUY8RNm4rU=;
 b=7c5odhDiF+aoEvaDFipB/OOXd8NZHegIz5aqnIfRId0PVLLarNwAzokb8yFvCnQjvp87oPV1k
 Agje8s2ugqJDiHzhpPrg8mTtb9APVmDukh35XCZCczigmxZQAl7ylq1
X-Developer-Key: i=puranam.tejaswi@oss.qualcomm.com; a=ed25519;
 pk=I7kFxZ7dcroo7ZWUatk8fR/J/KVbRzZq4ZBLhRRGpJo=
X-Authority-Analysis: v=2.4 cv=R5OWitRX c=1 sm=1 tr=0 ts=6afda35e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=dBqpytzp2iRCIsmGKUYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: bJSgBebD3tafskh-KnSF7w6owTK3yZr8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfXxHpYVWIWOhv4
 bHgbIQROZO0e6eDgaTW/TbXWBDO0iG6koz8LNUvKeF7uySUdwDsbZjp6xO7MnLKwAEzRVHYbTy6
 0bCsPk9CvHhgGls7as59PnLnlXw4+qk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1MiBTYWx0ZWRfX8Uzm1yvcDMgB
 cN3LV4EThIm3lb/0oJApVc1zJS4ixA4pOs9Jac9dyqCTQWO+/Qtjjz8y4/gGydiWS6dfj+5Tm4T
 MD3OUllC6Td6nOnZm5NerkqM9qXFS2N7/JRYyJw6J6EUn8SXZn0Iy6AIMrHNGx4eZJb0CB1JeN8
 xHkRMmwuT44GgK2Ft/kwXp2wMr59BSAmuYkCniE7zkIPG5w0PKrv4kMRvfq3OUpt328iMZSCFrq
 Y73FokKCYhNjNR7PHFhM9iSyigwEiKec8lP3OK7nAvL55Rk6O/Qwi9ACP4qQ2949Zs6so3TWOAd
 vPbW6H8fGEPSulG5BmlkrOFsSqAW69vBY3CP7BxYpnPmPD+gtRbrsk0A32UpWQhm/ZpGWnZbHMA
 dXq5zUna9oC4YN2Pr8Md6nceIt6thp2hiOx/j+c0uk1m3EeXPcdd273hheHG3LAFEhq+1cKNuVN
 /fbmfMlzuZ6xSNvWsJA==
X-Proofpoint-ORIG-GUID: bJSgBebD3tafskh-KnSF7w6owTK3yZr8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180052
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

The Adreno driver asks the secure world to initialize some GPU registers
through qcom_scm_gpu_init_regs(), and fails to power up the GPU if this
call fails.

Not every secure world implements this call. When it is missing, the
call fails in the same way as a real error, so the driver cannot tell
the two cases apart.

Add qcom_scm_gpu_init_regs_is_available(), similar to
qcom_scm_set_gpu_smmu_aperture_is_available(), so that the driver can
check whether the secure world supports the call before making it.

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 7 +++++++
 include/linux/firmware/qcom/qcom_scm.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 030e4ba90812..f4f34b7dd0b2 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1941,6 +1941,13 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 }
 EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh);
 
+bool qcom_scm_gpu_init_regs_is_available(void)
+{
+	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_GPU,
+					    QCOM_SCM_SVC_GPU_INIT_REGS);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_gpu_init_regs_is_available);
+
 int qcom_scm_gpu_init_regs(u32 gpu_req)
 {
 	struct qcom_scm_desc desc = {
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index a0a6bc0229c4..c9e88b2904e3 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -131,6 +131,7 @@ bool qcom_scm_lmh_dcvsh_available(void);
  */
 #define QCOM_SCM_GPU_TSENSE_EN_REQ BIT(3)
 
+bool qcom_scm_gpu_init_regs_is_available(void);
 int qcom_scm_gpu_init_regs(u32 gpu_req);
 
 int qcom_scm_shm_bridge_create(u64 pfn_and_ns_perm_flags,

-- 
2.34.1

