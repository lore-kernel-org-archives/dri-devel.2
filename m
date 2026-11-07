Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4732D606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 01:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jbim5pNr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XKdBeU3/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65DAA10EAE3;
	Sat,  7 Nov 2026 01:08:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E819D10EAE3
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 01:08:13 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6MoPxP1733195
 for <dri-devel@lists.freedesktop.org>; Sat, 7 Nov 2026 01:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XqszqiOkBMd
 k1vvS7oxfstl8dAzvdx7vbMieJ9TUstw=; b=Jbim5pNrPgMo+g46DRYZjAFuvhE
 Vr6G6u9Xl5bnz6g9WcIHzXufPefgfrpxGPN6+vQM5xK68i+VNDmTKdw9HS/3HT7E
 sLN064N8UnOJczaLEC9w8LKnUZH7XnNcPLBssD6EHqSoMAdVsR2TxiI4MSg+JkjY
 mE1v9RWM3WcNptQ7Uy7bBp7qLwVyekdd4qyZABfxq0rLy/iUKhM5MmsPVUGYg0um
 WTs1NCVnhnZX5QmM8/Mlq/Asxv7XhAr1SRQXkGoIvsvFcm7B5KNBOSVViIWaGRiV
 hyYdf57huav//qkoyn6x0MitT+TbwufIsIdrYAHV0GNppL8ldGIUf3SQ94g==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsn0e0y57-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 01:08:12 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6756044f260so424366d50.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 17:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794013692; x=1794618492;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XqszqiOkBMdk1vvS7oxfstl8dAzvdx7vbMieJ9TUstw=;
 b=XKdBeU3/v7CejZ/Gs5inVhgAD+m7TmHwVk7Uu1v+3XSd1QiiWgk5vjib6H1FwSg/vx
 Ll7xv1YywABzLsj0+KnOmscQgA2tFNyQ/jSh9hL1ktwbwYtthl0P7Fs0ZE+WYjTq/I/T
 LCCXXhboWWDQmSCeAlYjgx4cCYZZwbsZnc97RNjpRYg3zt+Dgse5kS30eilGl27X+iTe
 +Cr4PVtnfIiMBhXaEbuXyXL6fgYYpCq/jBnVfa3WZvXl7S0gZw2ir/bUyanyezoi7TPo
 VyV1KZFq/87hzZDunoMxWGPDmH/F3bdqr6p3kvcPNegnzHVtpUZT9OxIJ3u4l9TXzRXZ
 1Xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794013692; x=1794618492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XqszqiOkBMdk1vvS7oxfstl8dAzvdx7vbMieJ9TUstw=;
 b=kiTMy7oORIuDhLSm8SI32ZIuBHwNYiGuzq616WVCROA2bG+3g2osnn3Pr3PXj1uaD7
 1d8U+dRfoFu6oBm6ibYWoUn+dMpEGt699M9X1ghhTKLxap1KSgDEJz/JFs54aHrUeSC5
 +wlzqpab2veljBURFvJqFEJUwprTL9H2bi4PPmxf9gxIqneKBFhLorIsHbfCg1y6Ck5i
 Q9GZTpZnGMtW2/dE3DzwHNFzI6JMBHv7SAhfN1AMAKUr+KMAChwlCgarWIfTqzC3ZhBT
 m4RpVZ3WiOx48aMbbwCO57B95dqD1xKq3wDpwO8upble4Tbb1Xt8BI/OyoT/fX8zXNdC
 JEqA==
X-Forwarded-Encrypted: i=1;
 AL+hErGZkrWvKcbcvjjB8WIZ4pWyeTJ/XLLOJPKnfi2wEuyqoGlMg0aB4AhVaOhYfygP8kNBX0MfuPuAPCE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Bh0uTxrOJKC6U9G7mvMj1krE1voxGIBftOX6ISHWID8NtRSdO
 s+6vN1lMUkWRDwrK4/3OcfvRtWv3SZIlbwYL+xJGp1tPYiM8+wMNaO93/8AOMwb5Zn5pns0A6e0
 cFj52ln9LTbEz17M8M5LAkvK8TSBHzMlq9ezu8xC87WtX5mEoOOHMuabS72rN0X+2cl3gNIo=
X-Gm-Gg: AYBFou1tRZHrhiJIOysM4+J3wORRx2LhgnFfeZsY3jCLb4gBEm60EAphW8DtO5dpuWT
 txXOpIO3+wGbFlgh7CmrPg1XiGLZAn7fTnjSau3hgwCqZkWfWAkS9ELiefriuZryG3m7akuafVI
 S2tWemcH0zU+r/wCS0MRt84wEd3uo7EgvzDmX761PnKGDV55It4shz7Psylu9+VDssFYlhN9LWC
 6qrQ6zEfGWF8G70Aocnwrzaxf+ItuniYlcuN3u+Dqp2VeO4GPSGJ0NsBaoT28zP9v3jI3I2RS2/
 eobDwhm46+nRa2O/tybWYCtOyYeikSG2evkLFrDwbg5jmIgwNz4v81hgmG7gIPN1x7W2UOClt6e
 LtMpzZbv+IZoNcMWBzIIilsfEk9EzI+iERRpK3Js5L/ui5S7aeS3zIN4XRscuVYGBUOJJYxN8J/
 6iRyh/beJ24PrURE4FFAAxq/uqCwqTyITE+Q==
X-Received: by 2002:a05:690e:438c:b0:67c:f8c:22ff with SMTP id
 956f58d0204a3-67c29d038a2mr256550d50.29.1794013692291; 
 Fri, 06 Nov 2026 17:08:12 -0800 (PST)
X-Received: by 2002:a05:690e:438c:b0:67c:f8c:22ff with SMTP id
 956f58d0204a3-67c29d038a2mr256547d50.29.1794013691939; 
 Fri, 06 Nov 2026 17:08:11 -0800 (PST)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c134f0b5csm3091934d50.7.2026.11.06.17.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 17:08:11 -0800 (PST)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v7 0/3] misc: fastrpc: fix ADSP duplicate session creation
Date: Fri,  6 Nov 2026 20:08:01 -0500
Message-ID: <20261107010801.3451213-3-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102-dup-sessions-v7-0-03f06c014e78@oss.qualcomm.com>
References: <20261102-dup-sessions-v7-0-03f06c014e78@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: K3Ug9MaxJ5dRoFii3jMS3SyM1YwzbAeG
X-Authority-Analysis: v=2.4 cv=ffA4WEQF c=1 sm=1 tr=0 ts=6aee79fc cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=fP8dIGKjERIvVM-sKqAA:9 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAwNCBTYWx0ZWRfX5cx+aGebNgbF
 3df3QUvOiHWId2YJNTd3OzQRjlu5TUuAuKYifqwcVGy5xPQbJ8l8j17EhojFLgVXv7A/XefeWr5
 ioHwCHZUBZVIZsqIeAMeRFAXVCVE68fR+6JYQHL8LUY9y/msrnMTSuosyZO3kr+lBhGPVgoIAU4
 bxLBd4mOhfpncpCqXZ3XCcK+TRj4QKs6yiedS172HFgkNhMKEIBAFDMdqbtqqLS8j3both3p4NH
 BFhTA7X8oTeBr9tdp02/qhfLCepb0emayYXeNd46igSX2RNG3/9V5n49wwPIr1cHWSjjREu3BdJ
 goEbEHwjquGtbhkP0wK9gIOJ4axIqs5E0aL96IcyZ3WjmrbrmcIxU4aAA+Cm9WMBKmr7nDlyko1
 mJsFOSwMA6C1LbNHfuGRpUcwHuKzYCiuOYShvZ6BJiJ7ZBVREkDtAenvXCS6WuNlOOCQFc76z7K
 CHSmAsyJNkO5mPufWzQ==
X-Proofpoint-ORIG-GUID: K3Ug9MaxJ5dRoFii3jMS3SyM1YwzbAeG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAwNCBTYWx0ZWRfX0RxRqou1WPn5
 1QQDsDzjkOhGztxykv6r20QILQ0wvN6ocN0HdgoNF/EEeR0zRGERUZ34BS/P5gMdQZvwA0DDAJW
 8c9DdFE1hAnEN/9/vyk/Wh7BNpED8cw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070004
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tested-by: Tyler Baker <tyler.baker@oss.qualcomm.com> # Eliza EVK, EL2
