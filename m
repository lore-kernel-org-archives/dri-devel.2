Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D80CFED9E7
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C4210E648;
	Tue, 17 Mar 2026 15:30:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H5hq37/Q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TiYzxk+O";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3111B10E648
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:30:10 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HAju62254210
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=2hqyYSaS4VrNG8NPTYVWAJ
 QabhTTesNn0LmRhzY1g/g=; b=H5hq37/Q+b4kSAPhz0LvTLga3y5Z3DySsip5rD
 rI6qq0EYC7pMNfVUQQs3G7IwOLqLAO6k9l44iMOSKxYJb4kvkLH1wIZkJlO91JrC
 qXrS6KhW8l6rJvepHOYFmRh6cS+Ir5wf/oBOHF4k83LQRthaCLbrBnlYNbqV0SGY
 b86Yf8F9uTVbqIq/peKr3EjyeNUn+D2+vbqw3gsWz4rons4P95x46TmZxamf+4bA
 U2SHzmDKAsPQUFQlxBVFd6NAX/93xR5HWvIB6dM3Q+N50in3p7YwBS4k+HZ2+cUz
 N3fFAvxisIWutYtl6f9IYLr/Rxa3y04t3zmmVXYOfSzpY5RA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy5g8h11a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 15:30:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cdb995a1bfso3936241185a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773761409; x=1774366209;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2hqyYSaS4VrNG8NPTYVWAJQabhTTesNn0LmRhzY1g/g=;
 b=TiYzxk+Oh5avOap6PhlSOIVax0WTvsq37YVahhhUahwdfn8Xr5xTn5+0Elygf/RoPz
 vls1GeSAyok+tGqVtInBgJzWp9+cLcIDWtv8wuY8eYOeBeYCiR4/Tg7UXBOHfjlqUa3k
 uV7Hubg00Xq6Vxo0lzDjaHVMb4/BtJPKNSBm/o9r3lT7nIn9hzjqmpyRDoHAiYNxponq
 80hzql3TNHWCtRsHq6zTUcCXmsXvvXTtWcZ7GU0v0ixp8RPyZ81iSqpUv5J9Z+X/gD3h
 SENhKz6DDc5YMFuVoa3BguFRrumaHEXqAh9EWJjwbxeM026tnR7lHTPztGI8wFjqqajg
 l/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773761409; x=1774366209;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hqyYSaS4VrNG8NPTYVWAJQabhTTesNn0LmRhzY1g/g=;
 b=i6FzvR8di7cfvlvTCt1z1C88Mf2P76nMXI0uzAqNRedUm5N2DRakOnalWrYzWOBRRL
 gO0TkY2OuAHhV2J7nrilqpuUOBrDgXvJ7iyeR5ufIwO2oBMpcrtIk/dOGwSiKlpaU0EB
 zbcJDuCTUe/lFe5mvdTlO7V/obFSs07c/EwNbpXgUgqs2hWr89CeIY639cKp1T5AOg+z
 FDegzJC4dWUoROKiRuidH4Z5nNxBghhzgffKH25NjTnDnKcMDJI307AkfUc11Fv2NVR1
 Dzh6XdCwn90nk+1Kp1kFG1jzlsRZ2xMHxS3TcGUKg4PW0ZDxekYVGXCZ8r8bU/yJinmM
 qlVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtJbrgcKA3zD05qn4j1BDt0LVR91u+sxhfI58Snp8K4+72IAJ77e3n585osNcNnQCKMAB0AeKc6dM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrWwCWYVVTBu6FV7yoKado2eChpXvTJ6llbKSLOabaotlpqdxV
 +uWpfS6i2lLDJadzKW/vY8dEIXniaS8inrjg4eSUmE4CMUFJx1JWr0v/8SZIjx2iTP2F1ArcqyY
 vcaUBrzuJN2lSNSU+GdpMuYaUqXaGCeR0Z0RaCNHTdYzW4DQ9932O08Let0bircJJvdAU/IU=
X-Gm-Gg: ATEYQzwNBdocmQuWXNk/M48AgFi6LwgxH4dk2iUL5xaCcPh39W6MlUjRJ8AKdPYR8tx
 A2LZhU18vFM9k7EZ/zd7JP/DYk3dFJZppnJ+L7Ogu9y/AP1e3uNTkVm3jSL13vIcQY4cindYpTd
 4zQ0UBmbxXCR/buWvOxObVqLyBMId+oLohLyTVequz0R+5NBLSY9xFPg25sCVOEb+XsiUjJDBUd
 B03s1ia7V8tBoId///GmAItcBvXD9C2YON0h2Az3J86+mw64r8TwCweb0ZqXXHs4K3eTx0MNJbc
 IBWMyyV1DS3kWnzP3nqOxV2nYe2V0GabQc/PTZw8ZBQg52y1wx6A/Exxh3LkDcA9YAnAR52w0wf
 0RTOZnMMWzltP6F33qUwLb0bPC49GdJA4X6PvPSvhItr+dn9xWnoSePWQSmYqayIwZ2+axepojU
 ZwOrBRHhwLcD5V7gf9///Mt8E7Ye9qqdTY/2E=
X-Received: by 2002:a05:620a:40d3:b0:8cd:97a7:a343 with SMTP id
 af79cd13be357-8cdb5aa4d3bmr2317517685a.36.1773761408483; 
 Tue, 17 Mar 2026 08:30:08 -0700 (PDT)
X-Received: by 2002:a05:620a:40d3:b0:8cd:97a7:a343 with SMTP id
 af79cd13be357-8cdb5aa4d3bmr2317499585a.36.1773761407484; 
 Tue, 17 Mar 2026 08:30:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a15602e630sm4121394e87.26.2026.03.17.08.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 08:30:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 17:30:05 +0200
Subject: [PATCH] drm/msm/dpu: don't try using 2 LMs if only one DSC is
 available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-fix-3d-dsc-v1-1-88b54f62f659@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHxzuWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Nz3bTMCl3jFN2U4mRdkyQDc2NLc/PURENLJaCGgqJUoCzYsOjY2lo
 AMZ+5QVwAAAA=
X-Change-ID: 20260317-fix-3d-dsc-4b073977ea19
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=fiS+v1HmnasQUzAggFrQFAVyqQDaaFzdUqmjR23RuOE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpuXN+ZPtoJCWvlZeEDtkMzjrM4xDUmcWGMh1aJ
 84QuQJnQi2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCablzfgAKCRCLPIo+Aiko
 1cA/B/9vDg1tz2ba7zdh/eaW1Eh0xRGsoAKWUcd6aD2nkw2Mhc0O3uHDvwxwQ5bgsLKLz7jTU2G
 R3Ej03EzgJvClrTVEthrh7FIb7Df4xaTuHwvAop5em5NKPC/VX8MvAkFDIEFQFqiAbQQYRQY8hp
 OCYiX0gvhQfS7RIhJOYaWMd3/k7X54I8cMxq92LHVWRJj8davFeBCfGJ3FKypAvP6PftIV/8jKx
 6wP2Cp5IVnBqx1a+DYhcDu6cv3w0B0mvWEe0LJG+rSGsHso7awlWo+/RiXPBbh2N9b9Ut8jqHzK
 hvNm/SFao2/2VY/Vx9vGYZBNQaCaZArOritgb7HHi0twJ6Lv
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: cak4svr3HzTU2uIb2CFfBQwrkWjRYIOu
X-Authority-Analysis: v=2.4 cv=EeTFgfmC c=1 sm=1 tr=0 ts=69b97381 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=LbxHV1oPoWewQDzF:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=yYukBbz9-KCo0coATbYA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: cak4svr3HzTU2uIb2CFfBQwrkWjRYIOu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEzNyBTYWx0ZWRfX+Xq9JxE2rhr9
 osCKVIS8pmX+r2MQVbT+TeooMzTE+dq3djknrxzTRFclVD4KpjyN5mLYohhAhQtqww2QOe9lbGc
 y/ApKwUjZXu3YCRbrOCwgF/srzkQJ0qoV5CJNg7cTziZhW7MX6YVvFBkpAM+HaX7sQdL7wVGwxe
 09k6Eia0roJgIb4gLbn0Vw8DdAhmgbdXcDoEKfTsdLTVM+EhLyaqw/QJps0lgamQTwZc6SrZ974
 40EAbdWHCqHzCHwJ1BwS9O7sE3r7RF4IcPqYAE8laS0mXrglN79WMcEHFm8mr5VCWPbRQ+h9l9Q
 +PqoVo4Un4k4rHIhjr3B2Dg3fRcjVNCQDSn8VsrdoIdqECpukwsKJA7yjqdyhQQgcxyr3RB/Ye1
 wLGn4dnH8wNGqBumpYYs+F5dvKTI6C1Q9HwLUm7M5owF8bl9vp5bMKPt4Sy8tA5kd6Wk1Lbxm3Z
 B2HbbDuyhuPd+vSOKwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_02,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170137
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

Current topology code will try using 2 LMs with just one DSC, which
breaks cases like SC7280 / Fairphone5. Forbid using 2 LMs split in such
a case.

Fixes: 1ce69c265a53 ("drm/msm/dpu: move resource allocation to CRTC")
Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Closes: https://lore.kernel.org/r/DH1IKLU0YZYU.2SW4WYO7H3H4R@fairphone.com/
Tested-by: Luca Weiss <luca.weiss@fairphone.com> # qcm6490-fairphone-fp5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 6bf7c46379ae..96b67ea3fb4c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1410,7 +1410,8 @@ static struct msm_display_topology dpu_crtc_get_topology(
 		topology.num_lm = 2;
 	else if (topology.num_dsc == 2)
 		topology.num_lm = 2;
-	else if (dpu_kms->catalog->caps->has_3d_merge)
+	else if (dpu_kms->catalog->caps->has_3d_merge &&
+		 topology.num_dsc == 0)
 		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
 	else
 		topology.num_lm = 1;

---
base-commit: 50c4a49f7292b33b454ea1a16c4f77d6965405dc
change-id: 20260317-fix-3d-dsc-4b073977ea19

Best regards,
-- 
With best wishes
Dmitry

