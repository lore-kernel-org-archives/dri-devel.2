Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE50CA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 08:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9622010EB62;
	Sat, 10 Oct 2026 08:42:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fo5lzCKR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YruWGRPL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6597E10E042
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 08:42:53 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69A4dpYj2402565
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 08:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IqymoQ2HDibV8WA0yhfluVKdlQdB/7YbmVl1gD2ORD8=; b=Fo5lzCKR6ouvQqMF
 AfXvk7qHNy+UGr0uB/I75FzhO/oHguIgOagvJ50C1NXQUikQfyJk79H9vjFIlnjB
 bgTjhV8vSzS4dPkTiu8g6i4oO5GZS5Hbva9CkwhMzsCPgcJ3se2tzthEO1U0YM/h
 qqKO+KNKfG+Bwtqnb1VFRRoze4vVy6qBoY+WTKXije/fNbbTy3NigBrpI1x3+A0r
 uIlAHrfVf71v/5ji4yntBkpw+jq2Bhy0bKyGz9N8eUDWvzrEPHJpKe+wvJJZUPau
 BceKIvfkXsLXb5ZCrcR4QKdS/cROb9qNkdQ3r4GI9dt4fqy1ey8vUMAPPuUjd38K
 cYoPsA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7ehjgf20-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 08:42:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cc40759b2so110969685a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791621772; x=1792226572;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IqymoQ2HDibV8WA0yhfluVKdlQdB/7YbmVl1gD2ORD8=;
 b=YruWGRPL6TGV20+iTBx41WcZMCWrB9MQy3q8v68kmBRwsy/x9Dj2RTTrlezGE8eDUz
 Kl/F9Q4g1uZDZJkZlYSW85EQ531b5lM1r6m3Y8PP8NEaLV1shElIshzTmsAV3Jq1NtA9
 6ar86pRnWjSNxobweLRKBNcbYJEgJghy8kz+4WcJze852+rTp/cgU2SUbQuWWCTLR54I
 EBickhE8pod/aEg2PdzghL/h/ztZcTxBjfdW8h7aznI/eBfsk3qkIeTRTMjT4rprbsCp
 nDyamSYbRrmS7noMIAx/bJPw/92LgnNdgiH5wDyLutBys+FSEdqa293za2cUD8iesc8g
 e1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791621772; x=1792226572;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IqymoQ2HDibV8WA0yhfluVKdlQdB/7YbmVl1gD2ORD8=;
 b=cAu5lb1DmLgUqDhts1sXMVutXVoS5BvFEnLqNhvx5WZhIGENckNW832Q/xtelONUso
 MFKuNZ4lbPjQW+5vop7b3GYzqvcuhRYLQ00Xn8Euv6gB19fKy8cVpelEhL5KDIs5mO3p
 cWOTnq7rQq57PUqWYXhRAIIxM5eaUjqULIxAK5gf8Ey1xEPBdVJiN6swbh82ggbZKHIr
 erAvdSThXQTkZiP8aytwk5h0xXQwt22RvraIKDht9jlGdD9sYN4Q61nXcuohfgXwrVEz
 /uvVrnyZ/0C6EmVfmvDVV4z4047Iy4Z2HcaBgDhWyhj7ODPaVnv7MSCYRIvEGnf/sxUK
 SFOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBySIvIwXGxb0kgftquf2lqpBZRndgs7Kq8Uw2oYIBm2aTZQXXDabxtt4UMnqGUYoZrc56kvP5EQhD4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK8iTWcd+QrjPMv1r/II2488gYHxY3EB9oU+TxauK97eSNv+Wwn
 aE3P7kNlfwQLAOnCRgWlbDYVu4jUMnvT6ZNZ3F5VTB604G0yrUNcvvxiunQ/0cQ25UHvYRr06GN
 hYQS0tUB3319f4kyDxpjeWRO4fQmWzDfYmk0/0D4fU0Vn5wWRpXITuUrMzLAwReO+cYsWI6w=
X-Gm-Gg: AYBFou3pv0Wxd5qKnbC12GAGheI8MiUVWD328pTsReBS3t0cCweN65GIyjibhL37SWb
 kGHO0akBFIu43zpcq09seOXuav4T9UReue/Fl1gt5GM3yo7IZ/I2F2qteiDfrQ4NiB1DACoK6lj
 x39b1UwJ1ohLLQcVZqrYlRKvfAPgJlaRmk0IvMky/TNmTv9qznyESrhJRBNQMqFnneUT3+9VsR4
 qIMW9mWSjUr5Lrs+HT9lB0zEDR7Xn81SapikcaYkipKvH+BpOKcTXlpsuTkIdiJw/MwTO7o3iop
 P/Zi+iyLse1r004kcSyVu13ZLdNpAO+T31EDFdS0oeoMNLpsUH0Vm9nGgs1q4MUqzhA9l5mKX+3
 Ti9S4YL/FsTmMt5JRZNl4QeZLyf+b3hHOX7afmcfxBJ85ADutYPs=
X-Received: by 2002:a05:620a:4146:b0:93e:5929:f012 with SMTP id
 af79cd13be357-93ebd1bb215mr668129685a.18.1791621771781; 
 Sat, 10 Oct 2026 01:42:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4146:b0:93e:5929:f012 with SMTP id
 af79cd13be357-93ebd1bb215mr668125985a.18.1791621771276; 
 Sat, 10 Oct 2026 01:42:51 -0700 (PDT)
Received: from brgl-qcom.local (126.171.88.92.rev.sfr.net. [92.88.171.126])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a192d3efb6sm49065585e9.1.2026.10.10.01.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 01:42:50 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 linux-pm@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bod@kernel.org>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Alex Elder <elder@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 David Lechner <dlechner@baylibre.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hadar Gat <hadar.gat@arm.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Jaroslav Kysela <perex@perex.cz>, Jessica Zhang <jesszhan0024@gmail.com>,
 Johan Hovold <johan@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Linus Walleij <linusw@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Brown <broonie@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Melissa Wen <mwen@igalia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Olivia Mackall <olivia@selenic.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Rui Miguel Silva <rmfrfs@gmail.com>,
 Srinivas Kandagatla <srini@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, greybus-dev@lists.linaro.org,
 linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-staging@lists.linux.dev, sound-open-firmware@alsa-project.org
Subject: Re: (subset) [PATCH 00/13] PM: runtime: Convert
 pm_runtime_put_autosuspend() and friends to a void function
Date: Sat, 10 Oct 2026 10:42:36 +0200
Message-ID: <179162175231.5836.15015381844446264252.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261006231900.3230373-1-briannorris@chromium.org>
References: <20261006231900.3230373-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDAzNCBTYWx0ZWRfX1VYv5H7jrcGw
 b+/B5joPFObligEoW5fWtaN6wZDcozgxzEKBHsZNBC4Pou6wts+MwI0ds3wcyPJ4c3AZszO53kH
 a0hRL1JfFNtQM3i4lZIgUoGokQgbJxRtzp6831GA07PYukr6xmhfJiYQsUn+HdbZKvFMeUU8iBu
 GWHOuAJDrhPbekOEuS2Mt0pnmi3gMU4PDVXvhqaqclZc/bFNYVYPjHCByYGIX1Nd+/TCoQlPErL
 B1cahZlvotwUhUH9Mu5m1ozeZivmmeV2oTuI+clQ9Y8sAL3KUS6/rkYnaJA6KGVr1kU8Nko7zG4
 TQSzWcXoJs0T0IYJqvTfOrVPHoBcSkRGQ77E9AeVR7Myz+MlMhlb8SM8ksI36pQ8KfBEhmylr/X
 AK1Ll/rWVU27DnTWcv+jxTW7gQ/lhlT8tO7l1TmpzX0JDqf0QAjM+IG96ksK4hcGATi5JwlbtGS
 HJP959cPOp1vceCyAlQ==
X-Proofpoint-ORIG-GUID: L0PQngoHhtJG93XE2IFsatFia_E5IL5Q
X-Authority-Analysis: v=2.4 cv=MpTHeGae c=1 sm=1 tr=0 ts=6ac9fa8c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=3oaWUOhNWTYPA9BJS75j6A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rmSHi3-zQwwJBmM97rsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: L0PQngoHhtJG93XE2IFsatFia_E5IL5Q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDAzNCBTYWx0ZWRfX7hpYCkfR1qJH
 tzBYmbAOFtPnItBssTN6RGg0ZsMNq5CmiWhgIjrxkWHLeevMo45wRFKLWl58dAHybC/xBGnPwGP
 Wrwnm5F8np50GqdZG1jYLDYtL4mJIqI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610100034
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


On Tue, 06 Oct 2026 16:13:28 -0700, Brian Norris wrote:
> Similar to this effort:
> 
>   Subject: [PATCH v1 00/23] PM: runtime: Convert pm_runtime_put() to a void function
>   https://lore.kernel.org/all/6245770.lOV4Wx5bFT@rafael.j.wysocki/
> 
> i.e., commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void") and friends.
> 
> [...]

Applied, thanks!

[05/13] pinctrl: qcom: lpass-lpi: Discard pm_runtime_put_autosuspend() return values
        https://git.kernel.org/brgl/c/9bcd1725b0cc7954525e3d0d02fecaec7c7aab33

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
