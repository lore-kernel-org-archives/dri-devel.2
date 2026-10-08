Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC79CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BBBB10E5F9;
	Thu,  8 Oct 2026 13:14:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JiBwMqqL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q8NmztQL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA4C10E5F9
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 13:14:54 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698CXfh42763422
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 13:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eeefmzs9LhzY5+EVSVUwc7I2W02AzJRIpvFvDzODvew=; b=JiBwMqqLXOBphoa/
 aCjANvLZpvmQFpAb1DX0nlP+kc3Tlw/+44f+aUPdA0PCOTf5ZXGOtny/HpHoGUaz
 9zJvoKZ4g3E7w45VQg85KLUigp06bSfGnM6tfBTqN1sBG3ERSJsve0DgMrTxZU+a
 NTL5fIJTn9ZjvFLTi0XDrfb6Y8G6yPIzehx1HPcXpj3v/w8IwsjoZqSqiNmeubyN
 H5X3p3v/jzxHWknyABt+pPfOQyK2LWgqlPCVU8SJBL6AAkWZFxLK+wl/CBQBn04h
 jpj9BKUz5/YniKvx9ytCtr8s/yl9YvpSJpbZbu9U8sx87E2uR82zvRifdVL36Btq
 /1LqDg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6b9kg512-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 13:14:53 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5c7c0d2b0aaso1994687e0c.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791465293; x=1792070093;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eeefmzs9LhzY5+EVSVUwc7I2W02AzJRIpvFvDzODvew=;
 b=Q8NmztQLuuq3b/8QADSQsMN/wBWviyUF76kc7UbHqKS8vV1Q0HrbtDuBQ8hgkBFOF6
 HwLFb8vqdG8tc7gFs62AJUBq1PUaYuEBsex7NSWGO4msFLSYHEo99jfTIfFc9knzQkNT
 u1b2AHJU6es5JisPv/hqJEraLaWNWmGgF0MzvZ4PBz8/XIZLbpG0VSa3lm0xhgf9HHFZ
 IZCGwGPkYJd6jd/iIDFp2dWE379wIFaJyNF32UGR+Ge6MOORPmPZx9jm5Zs3/INu2RKU
 eoRNHwdVxG+7F1yXEAR07QJntlMdD0i+LWiLPe7/Y4qCODVu4ZizCkNDv2OkJwFkJD6c
 aWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791465293; x=1792070093;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eeefmzs9LhzY5+EVSVUwc7I2W02AzJRIpvFvDzODvew=;
 b=rBN2h1M/aFjIqejWyOcf+5DNxI7n54GjZNEYVFfIUIAuEQgz8WybSk0CXsZjnNV3D6
 sDGbpZE9km1tXzoSxOHN/VpieUifZrsYNBNUfozZRGWQ3WVtrkRYXSaNQJwyLXvP80MI
 hAb2sYWohq2YxnlVBZDvZpIr8EKG51/n2F5va56Y5kpSxKAid70eA9NsrZY8DCat/g4Y
 xlvjYBbe4Ic5lBJfrJmFFrRJysV/kuSl3Pzkn27fYfFBTJkS1QQ39BdW4LRLlB7RZ8Pt
 1ss0Pqowc0FaGMShJh4b4olpyvcjuUMVO37g0taKMI31qsERrQNLFMQ8Q4OANwknyQ+v
 4DbA==
X-Gm-Message-State: AFq9FYItbOVrD3a2gJWZ6tfS57rSjGyv+nv5H/gb+0gme2VASPn8PKWS
 UDoRHnfZy2IkoNf5wOAMqu4Vub/un3N5vR+3Miw6nNp5aWsZSuDzKfC6liakV8PEBiBoeGoyJUk
 NuH9cwDF34FkOAmdD4VJXCq/JmuxXYy8zqTjEq4Yn53hA5aRjNfZvskSN+YSneI4uJckbRrk=
X-Gm-Gg: AYBFou2IM9gSdjYSh1CeLwgKg57TslLl1ZWyxjJELNl1dchuu/iKn/i/G0tTOCggsSb
 O4Uvzzn18xz/nfawOxL0oPzsMYRDXatK0wXmDXfzWil6ozhqh3UF8zztG2Fjj98XPOWEqtniCdq
 S3fUxSXgjKxpTIxWal3ogUhp0auNymxJId71uQYIBrBH/73HXHlyqEoRLVpqmRyK6syckDL4G+D
 MUg6h9gPGYwler2KM+0B5SZEJyImyNfp/E4NHsqzjEStLlk+ucTRHpZ5HD++/nWHtwhl7W4De+e
 ikgpxoAd1/pHu3Im1PAT8w/vu44nSMN7RMK53bOkocjZbjylZs0GzGgT7d9fIfx04FvSdbXZqQS
 CrD8V7cdBUsM7u21dyBwrQi471fWm2Exl4pPNP9mJM3+qmgeOBxyOM3s9oTYBjispraw0csVfzO
 oPOZSJMeA9Eoqo
X-Received: by 2002:a05:6102:c0a:b0:7a7:195a:1b29 with SMTP id
 ada2fe7eead31-7ca38f21119mr1191661137.35.1791465293041; 
 Thu, 08 Oct 2026 06:14:53 -0700 (PDT)
X-Received: by 2002:a05:6102:c0a:b0:7a7:195a:1b29 with SMTP id
 ada2fe7eead31-7ca38f21119mr1191650137.35.1791465292302; 
 Thu, 08 Oct 2026 06:14:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9ae563df4sm8691441fa.30.2026.10.08.06.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 06:14:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 16:14:23 +0300
Subject: [PATCH RFC 1/9] drm/bridge: terminate the lines of the bridge
 state dump
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-panel-atomic-state-v1-1-b157fddb8de1@oss.qualcomm.com>
References: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
In-Reply-To: <20261008-panel-atomic-state-v1-0-b157fddb8de1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=D6Ku+N6JIzYkp6Cj9FfTJ7DgLhDCSoLWVqdmmrAqB0U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqx5dGergeBof+Ir1Y9fpKadE9sSryKVAMLgaX2
 1O19H0XINiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaseXRgAKCRCLPIo+Aiko
 1QruCACJxFBirr4cm6jgNgadta5LicAFfvDIC1fLiPRI1gBu2qCmyUJv1C67jnGMz1wWszQaMAR
 RSJq5Ys/grTuLG83mlU9qB6RN2BkSIRRjrwCr4ZY1f6heDWMJ3Vwi/V+DIL197fCH/MpyBptGZr
 19IZzGBJUo7kHsxcypuQoICyRmggvbsB3KVIDmQpPHIS/2YytXRYyAzJisX8x9eT5gNE1gMspzG
 tn9X3fcPDKw33G562Ve7Bw+iCzGpePQmVOkgZPKim6mE/iFiNubnpPnF1YeT+JFLFucJkyIz25S
 0lVIgZ14Y3/Tnsy7dK3AMrBh5+jrJuz/DLahtLTUlo/dNUYD
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: TvKvt3U6CUqOVTZeq7ixqqqli7VCPqFd
X-Authority-Analysis: v=2.4 cv=U98Hnuru c=1 sm=1 tr=0 ts=6ac7974d cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=aQ5-ZW0w08Ed3PgdgAAA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfX3YV5MTWfXK34
 ljrp5MelYDtLoYvjmmysjiad3RQTF3ePLTzDoLUU+LDI0NxolLWL9u7N2mgVZ5/o6Wt0kfJRXvb
 WnuWPJ7E/nzwxNTTprJ9ikgVxEAp+uE=
X-Proofpoint-GUID: TvKvt3U6CUqOVTZeq7ixqqqli7VCPqFd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1MiBTYWx0ZWRfX+lu+tZuYmmdr
 OSAjqxFPDbSQdsMG3ek5l0yaQMtZd6a6tJmfjvJzIvzT/ECfYpvIYebLjYQ9D3Fz6PltTbIR31+
 JIymA7cn4pdvgPimJmhEbe8b6D3f0IZT53ixlr8N2cdbjvBz3vlNT8QD7cMIIOJfoS94CYRrYTL
 Tnghgbg5hjwHd5MCPmyQVN3tNqg6O5ogYdqIfWVw3tZxLonKaSdklrjMUg9CFAC67Cbdc9vtZ0W
 FSEqmF92doB+XTYY0AYjsw8BMKFjL4OdSSq8z0Fp5LVhEsrbER313zyx68GsTmvXwjJe8yhb7JJ
 9RwbftakhuIb2fZNkdAJ7RJQdc3V1r9ifoVRLp9TZf/zrmG66zp7OYqrEZggFj5qYsx2KBaEPZv
 h299vdnkOtVhN7Tt9qt4erqTyjPYjC2h0fAdffSZ339sZfzsi//3Er2EwcgxLorY2C4XfJTFsmd
 9xc8wjjjZ9I/c6idtKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
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

The bridge state is dumped as a single line: the bus configuration
headers, format codes and flags all run together, followed on the same
line by the state of the next object. drm_printf_indent() does not
terminate the line it prints, and unlike its other users
drm_bridge_atomic_print_priv_state() does not add a newline to its
format strings.

Add the missing newlines.

Fixes: 4a7a146f1cc6 ("drm/bridge: Implement atomic_print_state")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_bridge.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index e7f9e6d58927..0f37e3ade016 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -565,12 +565,12 @@ drm_bridge_atomic_print_priv_state(struct drm_printer *p,
 	else
 		drm_printf(p, "bridge: %ps\n", bridge->funcs);
 
-	drm_printf_indent(p, 1, "input bus configuration:");
-	drm_printf_indent(p, 2, "code: %04x", state->input_bus_cfg.format);
-	drm_printf_indent(p, 2, "flags: %08x", state->input_bus_cfg.flags);
-	drm_printf_indent(p, 1, "output bus configuration:");
-	drm_printf_indent(p, 2, "code: %04x", state->output_bus_cfg.format);
-	drm_printf_indent(p, 2, "flags: %08x", state->output_bus_cfg.flags);
+	drm_printf_indent(p, 1, "input bus configuration:\n");
+	drm_printf_indent(p, 2, "code: %04x\n", state->input_bus_cfg.format);
+	drm_printf_indent(p, 2, "flags: %08x\n", state->input_bus_cfg.flags);
+	drm_printf_indent(p, 1, "output bus configuration:\n");
+	drm_printf_indent(p, 2, "code: %04x\n", state->output_bus_cfg.format);
+	drm_printf_indent(p, 2, "flags: %08x\n", state->output_bus_cfg.flags);
 }
 
 static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {

-- 
2.47.3

