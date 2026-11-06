Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9EE606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=omjr62Ak;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P3O8l2vC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A611D10EA83;
	Fri,  6 Nov 2026 15:36:47 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46E96112E80
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:36:36 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6F0LQP687901
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 15:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=8FPkuk2euvsx1j+tDah7Da
 Nr4rI/HTjPxRW4XcSqVrw=; b=omjr62AkNdgl7RMO8IWQdRcD2ABHI8QfJDWIIl
 ZzhF+iqEXxySlm4xCqQu9oG3XaJFr5OHCAQYLCBYHB9f1AWghtDBOOrtl+HKAjFA
 JD5PStfParddYEXTuUGgk9nXbLYSHbuOCjhz6pMUBwiginXV/wnwsamiktwm81iP
 RRQ26SX0fuhcXlFrvTB5dqipg9VPCFcqMV8bIlw5i1kx0V515bS5n3j2u7osUlVN
 MUTHnUSWBCTuM5JPyHAfTpeHODnJhs+UsIl3aYm9/u0SfNFutvrOgxr815p/i5l7
 2nNz8EM5OwW6A6WdtodqUJEDU5wot221536j9l4GQY3g5s2A==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pb3cva-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 15:36:35 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-99081ea787eso475969241.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 07:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793979394; x=1794584194;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8FPkuk2euvsx1j+tDah7DaNr4rI/HTjPxRW4XcSqVrw=;
 b=P3O8l2vC8wjpBcHS5lceM7MCO4C5OcDdDNDbF7BgvTZT1y2IZsd79BMrPtf30fRgHk
 eOLHmQOcdGrBB/QtaS+9SIXkdsRpASvF3qjfwwpK1yj3UCj9uxF7YBCHe8z+WF8ODFvd
 prgZIm/dhMcGdaf8DlNh7Kk3XaxjpcNwQueRpKSZcykDaa2Gh8FaZ0QU8K9sUka/FIuG
 lGCvIyh1YdXSfGUIvmCXMqSeYMlr5WHyuv84u6hMCzl3SgYA6fSdObulr5GnEifTDbee
 TrcivopPgOXUmxlT4s9W3FJJCqRLsewVvMg8afmM9a/Y9AYzu3LlHqyKO++6FUHhIfS7
 S/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793979394; x=1794584194;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8FPkuk2euvsx1j+tDah7DaNr4rI/HTjPxRW4XcSqVrw=;
 b=yK4hZ55FeMGVFalW6fJ9ANOE8ONDS4av9qN0O7OUdXxxGYipZ77pBMIEZCXuIS+Wlk
 V3YSQ4HuT/AJjAirfmp3h76zyjm1WjgsqLhiAYokY5FRlNu4+xYEnGr7P0xttl03hN/I
 ZApoT6ZDcCW2mzd31UMYYIkrAYTe0nvq4gsEM8WRZnF04xxsisDLVPvEjk9w7Vd1lI48
 VNmESfYhOKlLfUff4SU4wUV+0/edB5sS1eKr+PNmYwxdUnxu2TiPNBNjcGz3vcH3oLcD
 jaTO1R4k6wWjbY1m5IXx/jOXKep+BDQp5aJABISBAe8yiCiqyfxHGCFyE/Oa2K28L8R+
 Hgdg==
X-Gm-Message-State: APuU4Z+8AyQ7ePPvMtVfodO/CGqfWI7ztZaijuk1Ol1aG71fxgjqBmfz
 OHwZ4jslIrVwyyXtcoTNa+xi8wKxUfLztiNO31yGYWBhB/HowQrc2Eld2H+L213cZFTqqUyWUch
 pKZ3dr/HdG+NsDsnB4uE084jvblcCZdWg3PPAubaR45GE1ONg3FLCg6MZmaRNLZZykmfMTlc=
X-Gm-Gg: AYBFou0IgGivwtx3VGqSuEAxkFQfOgykpxKrcfrQDIWUtcPFHawPddz/qK9hQeC/H7C
 M+bnfRQV/UoKuku4cEjv74DQyXpxPsCDgAdfaf6oMOlyVtWQUwURDe1Hmm4BCESDGgSruDHHl26
 f9D0WdPIW1fGLurxxfkuVUeMjw3iFvRDeZlaCb77Tau1IpQrh4ejLahtDVhZs25K2f2vI0yz7Gd
 w3y+oF9DupwiTnhz2Hc2g65kHjWtdX49mC4nV4fHkbY6Zz4xUS4PyGJtR/5C1cHWmr55S/W6o6g
 Wd4q1iIaIWOyZya7xQ778HRolz/h03gXpPWX4zVsBub/II8F9KhK5Noopy84GbPB/nG3mPnhGBE
 gNC85bbHOd+b9BYjEUdfntrM3rhjLsZ/rnfFLGk0D3AR4KuAXgq4O0AiX8A==
X-Received: by 2002:a05:6102:291f:b0:7c0:c6e3:3b88 with SMTP id
 ada2fe7eead31-7d2a1618ffemr1706970137.28.1793979393970; 
 Fri, 06 Nov 2026 07:36:33 -0800 (PST)
X-Received: by 2002:a05:6102:291f:b0:7c0:c6e3:3b88 with SMTP id
 ada2fe7eead31-7d2a1618ffemr1706949137.28.1793979393258; 
 Fri, 06 Nov 2026 07:36:33 -0800 (PST)
Received: from [127.0.1.1] ([188.27.161.77]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d6d63b6esm4462129f8f.10.2026.11.06.07.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 07:36:32 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 17:36:24 +0200
Subject: [PATCH] drm/panel-edp: add BOE NS140WUM-L61 entry
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-panel-edp-boe-ns140wum-l61-v1-1-4c9747ec9186@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPfz7WoC/yXMwQqDMAwA0F+RnBdopFTwV8YObY0zorU0cxuI/
 75uO77LO0C5CCv0zQGFn6KypQq6NBAnn+6MMlRDa1pHZBxmn3hBHjKGjTEpWfPaV1wcobed86O
 NRF2AGuTCo7x/+fX2t+5h5vj4jnCeH10mo4F+AAAA
X-Change-ID: 20261106-panel-edp-boe-ns140wum-l61-a476af4c117b
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2597;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=TTDtDHbrg7cjaWgp0tDdMN18iFuexpk2NAksBiJSEho=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBq7fP+Um5J4O4YWjly4jS+ySpv88WtFVY/cwBQ8
 Kt7eWFMKuaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCau3z/gAKCRAbX0TJAJUV
 VrDWD/95bkqpNbsKuUdE5tEukr1oQSnAiyKHtyNuQLtz1SUlylVU6XYUKd4NnX2PeYi9hcm9Aqu
 gJEgiYRvN88B3L5GRWOALTrPmiPKw5h1QhIQDcdggcFlLcp1TnkT6wnfsbxa7hPuqimGzJUFVPh
 vHmU0hKK4wVSLgs/mOGlnz9q6hlVlYHT89UhzClRDqshedOH8RClRTBUwS4zyaDrtiA+SHG3Vd5
 vtYFgAn5DQ6h2DnurOaEvDhFGc8qMS9Iv+jYE51BkATcuC4Abhn19thHINfkTcni4gnEWj+AXTv
 3+xFprAFa4WfcggzWThb/DLa4moffPRPHImtTPrTJW/WdDcPud+eTXpHbpw6srHBrep8P+As4dD
 CKYe2/1Yw7wZelOj2vj63gp5gdCB2Or8Vx3Cy07ZZWgCxQF33wrMPdb/0qvy6HyMLgJEyFzfPs0
 EzJsvJPb7QYLbNB6V4RuOv/kfpA8r/ZHve1QNd5n2ZXS7SSaNCyyPGYXeQA6zCNZ0wNqZhaBGK/
 kqEx+F/9tGwqH0NOfOqWLc6JO8RLNmhvs1zWWewcXlBr3MkE12ffmZt56/OuWkjWHoOMkA5B/vX
 wS3he1bxp7w34OJA22+lGdAudqFheGPjXDceZFTWVATqUKvw1bJMfxhtShTLR2JJybpoiBS4Aqu
 1c61JJPWQKN4g9g==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-GUID: tdysnjeozwIk8gOjSwTGWOGrG7IHmZLb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX6H+ogvD53nlq
 x27lVAFn2DiC3h4exZh2ECEfuXLH/ufXaZVwKQnGHNmAqerbaQtV0PVysVD7VYz0OG0O6OqRyl5
 evlqa5Gk+uDxpBuOxXVUFRugxUkvrcI=
X-Authority-Analysis: v=2.4 cv=LIrz05W9 c=1 sm=1 tr=0 ts=6aedf403 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=K9GtLKQmH6Xbff-BUrMA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: tdysnjeozwIk8gOjSwTGWOGrG7IHmZLb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX9Yx/EKOuV11A
 48iHfiSNc2BPaec8y6FRPBhmlKMgpVJyKOcgXmrpdTeUG5792CX1T/CjqSaNijFmTAtZZEylzDo
 9694mUpOVojFByBUN90GE0cAzlpZ8DxSwIqnw/j+16je1aqex2AzngTDNXWtQKv0isqKuo2w+YQ
 DCmBUSE9STCiAKqUSUfQJ4Y21NXevs71n5TZq7Opojxk5qdmNP0SPiCgkB1/jhLLUADt0rCUHOZ
 ZhAr2JtVdQUr7Pg79LZMYnAFzngP5An+cF7/JdxduzWr87rmiTCOKh+Txg0ky4gX8/hJ5ALqgo9
 5YV43d2ChB/XQH3qhXjg4bZjIII8KDpfrrVx8I8+Nhl7axltQ3cUYR0fz6UiWAcAS7AID0ZqgP3
 bf75KU+PIFSf4rKdKjAFlJdvKVVVJ3wXmCQ2RzGSoRzRY/Qkfazgfm4i0f/lkZoN57lUFGThMpy
 kUykTpTePygcjVivKag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060062
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

The Lenovo ThinkPad T14s Gen 7 (Mahua) LCD variant ships with a
14" 1920x1200 BOE NS140WUM-L61 panel, which reports itself as BOE
0x0d9d. Since there is no matching entry, panel-edp warns about an
unknown panel and uses the conservative timings.

Raw EDID of the panel on this machine:

  00 ff ff ff ff ff ff 00 09 e5 9d 0d 00 00 00 00
  0c 23 01 04 a5 1e 13 78 07 53 38 a3 57 4b 99 25
  0f 51 57 00 00 00 01 01 01 01 01 01 01 01 01 01
  01 01 01 01 01 01 10 44 80 18 71 b0 78 40 30 20
  f6 0c 2e bc 10 00 00 1a 00 00 00 fd 00 1e 3c 4f
  4f 11 01 0a 20 20 20 20 20 20 00 00 00 fe 00 42
  4f 45 20 43 51 0a 20 20 20 20 20 20 00 00 00 fc
  00 4e 53 31 34 30 57 55 4d 2d 4c 36 31 0a 01 2c

  70 20 79 02 00 81 00 15 74 1a 00 00 03 51 1e 3c
  00 00 6a 3e 6a 3e 3c 00 00 00 00 80 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 87 90

  Manufacturer: BOE
  Model: 0x0d9d
  Made in: week 12 of 2025
  Display Product Name: 'NS140WUM-L61'
  ASCII String: 'BOE CQ'
  DTD 1: 1920x1200 60.000000 Hz 16:10 (302 mm x 188 mm)

No datasheet was at hand, so use delay_200_500_e80, which is what
the other 14" WUXGA BOE panels in the table (NE140WUM-N6S and
NE140WUM-N41) use.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index ee880dff5e02..d93436746c97 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2082,6 +2082,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d73, &delay_200_500_e80, "NE140WUM-N6S"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d98, &delay_200_500_e50_po2e200_d100, "NV140FHM-N5B"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d9b, &delay_200_500_e80, "NE140WUM-N41"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0d9d, &delay_200_500_e80, "NS140WUM-L61"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0db3, &delay_200_500_e80, "NV153WUM-N42"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ddf, &delay_200_500_e80, "NV116WHM-T01"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x386e, &delay_200_500_e80, "NV116WH2-M30"),

---
base-commit: 09b4318c0e8a3d27b1fe6a2765163c1c52e321fb
change-id: 20261106-panel-edp-boe-ns140wum-l61-a476af4c117b

Best regards,
--  

Abel

