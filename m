Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D673A606A323
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hulvCuGj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BF+wN4QD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3511610E7E3;
	Sat, 24 Oct 2026 10:30:47 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECACE10E14F
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:31 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O8oOqU3828306
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bxknWd2sQZ7e6sMxroosiyVGZDXHne6mb0NckvWbH0Q=; b=hulvCuGjbJz7dhCV
 NKTJ4uLEBNyHu6nmZ7t/Ra617NjmCzM0qLJIjbK8tXsjE7VqNY/4SjGCDLvWT2kk
 ljOTO5iVNYyKEfPpl/Ba3hB9gCc+5KHsY07aFKoENc6fdd4+haPYjHLvI1Kj7Myl
 ziuuSLZFlvYpQiX5F11XSxIqfQeFhmxw553lHHOie1veXSZCMBgUvrl/wwS0qlSh
 OEdx3qX4z4a/IQVrdrCODbkWM9DOZvdbdL2O++5oOjBBi6ysTe6N00fHyYPsF+Tq
 SFk1uabfQcfCo1bkbOQpLc8i50zHfXWLh+Ra8Yy/oCqRieOJbHB7GsVZHPnuxOef
 ucbACQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnuk8kd7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c902e0da2so3082222eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 03:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792837831; x=1793442631;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bxknWd2sQZ7e6sMxroosiyVGZDXHne6mb0NckvWbH0Q=;
 b=BF+wN4QDFeTB/Den9tqdsbbc2AUFs1ZWggUnyQCzlHDAPpqHnlkKLOZoLp1MUY0Cbv
 I5p11rDAu8M50EIFVCIBXBxJoWJT2AsYS/Riwiiu4/Jl+jrl6DXiLw+td3ejd3cKWiUv
 vo6jxw5pre93yn06jpiRPvS4YDIDRczI9+q2sXUlCeETbh/66LtA2zWAfyeSqDR4eflI
 3SQt5hPEDOPFwkmxHuQmYuwTIrexVV/MuyrThrci0Gmzs44LwwZwb/BZgbozr6DFkYF1
 OeghXa8pWTEZI6/Gvk4pHlNgPslQOYexx7R7o75kJ3SSzBNX8kSjqMoRVDVHn/Z7IRM2
 R/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792837831; x=1793442631;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bxknWd2sQZ7e6sMxroosiyVGZDXHne6mb0NckvWbH0Q=;
 b=C1+t8dVCgJG4awVCQEhmuDDSrNIZK066cFpQuNDNw5zRqSTToRYgv2f4gIzzZAy+zf
 XzwKUgUuRoJpCWWJVQ+V8jAMjdbRs5Q88fJ/nQTzOX4lMtj1qmQaXFUFaFc5QG4bhBXW
 20WSFRbL2C9tK4FbDfEvAzywGGpFSi4U7UvM8bDg7Yizr6mEBIhUDU7JCeBUd+cAMZqP
 0FuF8a3yFxePPblGKXHoRnTLstz7sk3ry0/DJ2XfHBw/3dWqXARd5hkZg21YKgrfNV9a
 9e1pWgjiBW2ffTDk7HM17Bf5SNsuP0sRHoMHvsXx+VJTGzspmLc5BUFc3IcXuauXvU+W
 G/DQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzH0gC2oe0IyA3rtTysKZjPDQnZpWEVuKYJx67CwgyUdzUaYp3wSBGjmW5+xMi9jWI2bEhIO9cbJ1A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJKinJ3YHGxTRDw3ZOdQrr/n4e2V6WREuLuBAMJ6nR767IirFyE
 3zrP9JkdwYs9cLWbgW5+WFbMT0/JBDTkRx93XU0Nfe/BFg3hZYqe25ErbB0UTOz7Eu1MZn4ZXb7
 ZvsJqwRriCMoEpDnC2YnDktaDgQN6SofJlq6EdpoqVV4rw+KeS/iyqwPhyqZQKwln+JuzdQM=
X-Gm-Gg: AYBFou10WRNqZ7Un2sJWnrnNj+psFP6IXwFYY/wE1931ZHA8imh1kn9dkAcH0edin8y
 9UmpYoMvYm9wplQj3awUwfMsKQybtG/PomAn1Ux0BMyABCCxLALZt83AIDTnCCIy5BDXath7R6p
 zHlv4HM9sIDNI3XFPW63XXq/UxWOJaNgPXQ+L8Zozgj1KcSpt42FHQhB6f/Xw+uUyI/TdJnHxfH
 sI6nTwXIs7rQy5JHpH3LKiRSxZLcMZJxdmCPKfQ2OddmPPYJU6/DrDhSmtCNMQVUiL3ka3+lSyG
 tYxmABqg8Jbekb70ciHVBYWKeBlrgMAi7S+PjbiapgxqRqYIx0yi2pC9lnWJXYC/6OIYZqH0U2e
 AVq07itBI4uqdOD2ytHy5fco=
X-Received: by 2002:a05:7022:5f04:b0:15b:1959:15e0 with SMTP id
 a92af1059eb24-199344ccc36mr2134257c88.4.1792837830617; 
 Sat, 24 Oct 2026 03:30:30 -0700 (PDT)
X-Received: by 2002:a05:7022:5f04:b0:15b:1959:15e0 with SMTP id
 a92af1059eb24-199344ccc36mr2134207c88.4.1792837830034; 
 Sat, 24 Oct 2026 03:30:30 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19894d5a10csm6009441c88.1.2026.10.24.03.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 03:30:29 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 16:00:07 +0530
Subject: [PATCH 1/8] drm/msm/a6xx: Check BX dependency vote index
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-assorted-fixes-oct-v1-1-2977f974ddb7@oss.qualcomm.com>
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792837816; l=1147;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=OZgbZXRHjUVB0GyiAJm80VqQFl7KVDIkYEEZVJ4qf6U=;
 b=TZ+QZM18swWiIyEvnvhoEsmwG62YMBd4y5BPM3aJPn5Qe55JxWuo4bjV5cDhPB2ekv9NOHM2/
 ueliz1/ELAzBSCzQcN+6erugr+JWjcoqmwQ6oKnDzetS6RrPHB53BQy
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=Z8Z5j3RA c=1 sm=1 tr=0 ts=6adc88c7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=UiV5_Nx6FN_ZUZKxJi4A:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: hDAhNcQhzXbDHPGUKIamV-5hcGO1VyKT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfXx0Z/XD2uwSdy
 5TNspuvkA1BdXhi+CZ62g4qcNQbZuS/2faxXrmQc9rbDbjNaZUNloikjjc7XgAKBtIXLhnylqzp
 50J7MuPdODNKlF3RdjFZqjLmir8hTzo45veCk+J/xSNzZ6c4dyg7VqkXaJa9+22I4WE9MxEbRMF
 alc5RfUrEOb/3pL8H5wYr68pJn+Brd7kwA2hgU4AZb68C7yjL1prqmiztsZt630ZdkX9aiMvNzS
 lfnLmaTe2Qfdeu6Due9Yr6bCBFz0OxHwMzxzVUp+fBp/zqttjnolcy+ZdlJyszT+z7cnnAu2KWT
 i7ESxvrzzep6NE5pNNkpBOlvnBxHGuyO55w2BwWrcWe70pqDcBEi/15gM5vmUwcxPBcFBwRnkl8
 yCl2e6wzPsAN4NLCxg9PIVS9I+aHfSzClFcpUJDTANZGRV0IZ2fMF7KJg7IQvuahoxJKcCwfkhR
 0clZAimZM5JSipsgR0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX88Z10xudQ6UN
 WvEWV5mW/LkbFBSpjML+GegU4GQu3BseQ08dvBtCn5EOp5hfGOVDMOmcxcTj9DHVu7MVq4Uj63a
 1niWPc0H1Y6kvcjhXvThjZgQ9NxUyHU=
X-Proofpoint-GUID: hDAhNcQhzXbDHPGUKIamV-5hcGO1VyKT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240041
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

a6xx_gmu_rpmh_arc_index() returns a signed error value. Check the result
before passing it to FIELD_MODIFY(), which rejects a compiler-propagated
negative value as too large for the field.

Fixes: 020b8eaa1db8 ("drm/msm/a6xx: Add BX rail support to GMU dependency votes")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610070334.bYvBJSpj-lkp@intel.com/
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 662f09bec9d5..9e02d6f939af 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1867,6 +1867,9 @@ static int a6xx_gmu_rpmh_dep_votes_init(struct device *dev, u32 *votes,
 		 * back to the highest BX corner if none is high enough.
 		 */
 		bx = a6xx_gmu_rpmh_arc_index(dev, gbx, gbx_count, gx[index], true);
+		if (bx < 0)
+			return bx;
+
 		FIELD_MODIFY(GMU_BX_MASK, &votes[i], bx);
 	}
 

-- 
2.55.0

