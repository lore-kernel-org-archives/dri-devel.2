Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A455606A33E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PaX60grQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H5hlR4UF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4430510E80C;
	Tue,  3 Nov 2026 13:34:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB34110E80C
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 13:34:29 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3Cl2G33922492
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 13:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DTqLAUKcdunUoMIDUDVQW9cBAtclBrFvLZfGH8GUl2Y=; b=PaX60grQy2eNFep0
 DO3/PPj54urDEBHx1h8NEYiDFY57Lq8fD8MmHEsFlTANYufLvVHkzSUTCk4EScwK
 Tku3i4Z9MMln/T2hs8xTmb/LZ6w5rpWZ1TRqdwGY0Z74mvFXntUURJaQ44jQs3dY
 52Ymhjr2KHdreS87YmrR+bxRFhXEca1Jy/yVd2FolB/o6mc0s2K07nRXLImQZGN6
 Mt6xSUdmj66I2ALx4D+zOIvSPYbn7h04f+qNfDhfjlCh3Xnv54fPrW04CYHtYKPc
 3+Kyzp6RbKix2u5uwG7hxj8L9iq4BfR8Avf1GjKafw76pJcANkM/PnxBdHqnIEz/
 7xxHNg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq76dab8m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 13:34:20 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7cc06b9ca9eso760732137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 05:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793712859; x=1794317659;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DTqLAUKcdunUoMIDUDVQW9cBAtclBrFvLZfGH8GUl2Y=;
 b=H5hlR4UF0mQ6rBH6/vJ9UgWV3FQZeNPzpeb8Z77RkYkBwy0N/2EAkM5B79hL53eQMj
 hoyKTHKxuDNZDu8vykEESuQII7u92q6a0eKrqWhVFdu6MOCa+c6sDGCybU/Nc6PwHW1d
 7DuN/3TyMY7/6dQjqcqslzYA8hiREd50qhyAT+yXCOXdXujWWOo9nGMgq+ugZqaDsbgy
 sIGd8vH72uLsMupl5+/NF5rGX9F6TR87lpmg6ZhABn+wbOUaK5ACs3pNJAi2RA7ADnL/
 clQZC2ggh/E78beNn7oPehq9QqoDOD+OfxDenRCgMa8ywXOmQJXgfLdw9xrRrcX/Nq8z
 K9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712859; x=1794317659;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DTqLAUKcdunUoMIDUDVQW9cBAtclBrFvLZfGH8GUl2Y=;
 b=TYZI1MVYccJvBvxoWbSXqAtdJcvM1Qhg9r22mFCpD7suQMjCz6/VaPhlnDASAGlIYd
 m4joUzMy1qm2pazUAGgUWpbOyecmXp99GuoVStE1Lo+BBQs5vYY/O+HbE9gTUh6Wf6+8
 IBOXfx8+8ekMUqiofFiK48pthH1UdWqqtaXDGu0vQM7b0IT5GxR/2qwrbfKXS9auEjwl
 RlnYh+DNbfgLCEQaRkYdlT0k8ks3Y4WQxj00SmQ/jQTxjSbkVAzw/6NNlDIljN/ISKk9
 5zs6UePNShrG8pDWx5H7ICpA0gqJC/yMJsqChZMM3gThntaUvZCJ5UNEF+IDbu8KA7qW
 I0Tw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1gnAeGkw7+7NZEr+Ns1uc7X76uAms5NAm2ZxdqqAiCVQJdBzfRCAXxzxpy0/cwHhRS5DsoTfMYkI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8EbXQzUrZHZUg0+/8xPS3dvgC8aj13947qHjg3suwdrF00tBKr
 1viuf8cZxCmyggiQbOeqXjYrNf1uuPJLnNoLDIvK47v9YnEUOxj6NOFSlo54DmZDZWDJCvUYayu
 n6ChuSyTcRhwps/YIk47NmDaipGBCXOXqduLX5Gl2SDjonkn0/tb6APITJVFjM1v+so/5Wn8=
X-Gm-Gg: AYBFou080cB7fqNHf3Mq39gbokvSJTwcJSbR+5t72swG6S/lOs9fDOqGm6gpBC9/NUp
 KXOxXgA6uue55oN75gRJnFhmZagFTeKjcl8jhdd9epoZ1/L+bF0a4sr1cuyRYs+Je/B1e/2nGrv
 rZrfzZT2nd8l3iRBQ5otWetWrbSaa093yNM0pBh35V9rh3dG1iFsrXJjTh84VIvPDGcnWyM9WW3
 AgepJs1d/Gq9Y+TsbtqUFzMKLSpnSZ6sLNsudV1/WCmHnIPygd/4TxPcVFkGlQ83N5pkgUk+pNM
 BFTnd1z5QRIZarMnRF1FcpenafUCILdyQCaxLCpv6LCPldVrKOUqKQobegNYB0TuyPXil5PJiak
 t+DDSgGrNmxfI/vo19Oiznr6YWtt8kdgwcDPeORXTscNKU3D2Pr6Wnu3jkBxucNbJvkN5sx5ICl
 lR5g==
X-Received: by 2002:a05:6102:604b:b0:7cc:9d46:ac88 with SMTP id
 ada2fe7eead31-7d072626935mr3533211137.18.1793712859590; 
 Tue, 03 Nov 2026 05:34:19 -0800 (PST)
X-Received: by 2002:a05:6102:604b:b0:7cc:9d46:ac88 with SMTP id
 ada2fe7eead31-7d072626935mr3533187137.18.1793712858980; 
 Tue, 03 Nov 2026 05:34:18 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm26866970f8f.55.2026.11.03.05.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:34:18 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 14:33:54 +0100
Subject: [PATCH 3/3] drm/panel-mipi-dbi: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-panel-mipi-non-exclusive-gpios-v1-3-aa862c1d71e3@oss.qualcomm.com>
References: <20261103-panel-mipi-non-exclusive-gpios-v1-0-aa862c1d71e3@oss.qualcomm.com>
In-Reply-To: <20261103-panel-mipi-non-exclusive-gpios-v1-0-aa862c1d71e3@oss.qualcomm.com>
To: Russell King <linux@armlinux.org.uk>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-gpio@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1340;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=L77EVNO37nJ8bqShHP/VkH28Qj8EpKeHm6Kw3WFdyMI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6eLSAKCGRs/5xWd0LbuvTkv0Yz4BLBG2Wt+fx
 WEuk0Rn70OJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauni0gAKCRAFnS7L/zaE
 w1m7D/oDxRKdjJGFSMRo90SmI08LhWyVliSQHqb9JufJtsRCV3NGcX4zCS+jMU4grEWv0lfuXu4
 6+4yVk6EQyvgJWHhRyWISjQbGRLHjMgBMZ9BZ/aJdVT74Y+OyN1fNWO6Tjwt3hll/O4txb57Cx6
 DOxKARd/3QmK0BGXUEdHAafVAddJBW9ERKPc3rzCjHVamct6gAoJlElxXM1KRmyTGBsYjXQ0Y4Y
 OE40frmKz80lBd7jlFF3Xp2+pS4uL76NuhhpcIQTOYcvixff+ItacRK1syYVL40xIG+SD3FBlh7
 z7t3xJ8ES0U0guj5vwRBpJa2xOFdKe7z4zHQAA7rFtwA0vmgKpPaK+KzlVi7mNLZwStySmisjC0
 wfhKFNv4uuTiaza96qK6pzeg6UC41Ejwfn8y1DbtNuHYebdPLTUQKHNvve5FNAJLr0xkcNErbr5
 ubhpZ9hiOtBdsG2AEXM0C0sryKXmynqccTydaaYRrtaY9xABHDk288XLpglrFrF6Hoe3zBbBrZr
 eLkqDB8W/ZgRR9exnAXnfgO+aURE3oqvdFz4blA8o/dMao86USkCnoxUVDxGxz8EH9Jrlj8CN3H
 zaSMeQ7LI1ZT3IvnNKhc5Pt84Wnc1aYPXV8DqAn4hNaP/e/4fBE7HyaWGDRDPE6KYvHBq29oNHX
 sE7DR92bWXgVLvg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=KJTPn1Fo c=1 sm=1 tr=0 ts=6ae9e2dc cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Mb4fkPDSjR1CXLPVujoA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1MyBTYWx0ZWRfXwxzLHC7HzJg1
 hB97MVaLz2GpK/mp3TZZnFcIPlz5+3Ltd8UTwONVgXNEH1MG1bqB554jiVBva7KhjbPPmrSu4R7
 EAsR1btj4sgPOdeN6wJQj9ey6for/uQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1MyBTYWx0ZWRfXwsan2nYhytio
 qrp3KLcWEzA/xHGu8bGFZLBjZBQnZO1NFWY1104ge06WRM4jCs77qndP9ANacrTTvzYGd7qHYpr
 9wsUvs23Ztxp4Nu1up1HEvyAlplWfOv5cZYeadWE5n01mZ/uQnAqGN0Qn8TOujvUIItnNhM7TWC
 Ebb5TK4I/LYHQ5zp1kO36nYrbsy7BLF8ikP80oyimSSnSLxziquArG5VKbp7TQ+VZivnq/pqYHp
 xHcFnu4ZKDLFh6WaD8SlJSwqrs/WV6NEoEr/iBIpXkrshlewIqvmIrunBcFbkJoykX97QE82PF7
 OWmHHalw6WLcogSo7xYLv8+pIVo1G0Mzei2nsuPWev5UepFtQS7vVpirpjB1eiEEcDWHyY8D0Vb
 Vm0xISsU73TRNfCBvjxZZo9z7fjXABh0mV7y9ds066mV0D0xUZ768gU/C/q46SF15HWMjJSnTB6
 O22gvXVIAYhFHwaKaQw==
X-Proofpoint-GUID: IRDoBb2MTDy_cMvcsjuXGaEBdJxIvmx8
X-Proofpoint-ORIG-GUID: IRDoBb2MTDy_cMvcsjuXGaEBdJxIvmx8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030053
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

GPIOD_FLAGS_BIT_NONEXCLUSIVE is deprecated and will be removed. The
preferred way of sharing of GPIO pins is relying on the GPIO shared
proxy provided by GPIOLIB. There are only two users of this driver in
upstream DT sources and both now select HAVE_SHARED_GPIOS so we can
safely drop the non-exclusive acquisition of dc-gpios.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpu/drm/tiny/panel-mipi-dbi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
index 60cd65cae41d8d4f4f6e5fbc57d5d34058ca4d38..6f09b723cd7c352b0a1ea9f11a2e58052978cf0d 100644
--- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
+++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
@@ -418,8 +418,7 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
 	if (IS_ERR(dbi->reset))
 		return dev_err_probe(dev, PTR_ERR(dbi->reset), "Failed to get GPIO 'reset'\n");
 
-	/* Multiple panels can share the "dc" GPIO, but only if they are on the same SPI bus! */
-	dc = devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+	dc = devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LOW);
 	if (IS_ERR(dc))
 		return dev_err_probe(dev, PTR_ERR(dc), "Failed to get GPIO 'dc'\n");
 

-- 
2.47.3

