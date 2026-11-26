Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DBE606A327
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VHNHPIPJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aZgp11Y/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CCA10E4F5;
	Thu, 26 Nov 2026 08:32:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00DE910E4F5
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:31:55 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ8NVMn2859739
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bsFyyn4glzVRtAEYcoWdywoe9cNyQJ0bI+XLL83v7f4=; b=VHNHPIPJMFTm2FRU
 Ec47rd255jdGakFPiT7uMNt5jTPVQ1FicYqYVdwYenErQFi/LL0zxANpIH0/9R2v
 CaxDDGSgDdEcY4K7pleWjKTGOdAK1Mgtb9oWb9GOnAt87/eEaslWMZupabxh2sff
 xUNxi0+qDzGW8vT5hvGc5/mnnJBo0P1zdev6DavGVL6ePh1vfaa9UMWb+YbMWPLF
 N/D03OTZ47kaP4nP+BaIawczseyDP8EAkW6AUV4edvJDPvf9WvUFnn0BEYBP0oHk
 eOYrTAnda0Uudxk4Ns8q0cZI5VUeC7BX+R1th+ME8biWt1JXuc403hEXPY5wTB3i
 Mv6H0A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6h7g81af-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:31:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f1f1f2ecfso56038785a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 00:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795681914; x=1796286714;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bsFyyn4glzVRtAEYcoWdywoe9cNyQJ0bI+XLL83v7f4=;
 b=aZgp11Y/uvfo6dT4D4Cxc256EwETVpwuSjD1Hf5MICQ4dTR0h75YLAVi/gDXOLfco2
 ZBym/OhBvn7rzbuuQ5nU3n7Qr7nrb71XR012Xdr4kaYzbs2lMI4H1Ba1QjsBgxwB611d
 LT9CIeiJCSf5paU/by4RmoTyVh+zvCbQObXQvsc22I89SRirvhTdm0XgryTOgadvNqKO
 TlsuLzKMmXOv5OU/knot1xmvO4fFYer9EwzqXAiPgC1PWU68LfcI3xGMuGB9qjO67Ni9
 DnWtpk/+7r7Bs0W2gUFFg3HNTIBwCopmRSvlLzw9s1TTg1xDvAMtUJCAcpL/UHrCaRI9
 fZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795681914; x=1796286714;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bsFyyn4glzVRtAEYcoWdywoe9cNyQJ0bI+XLL83v7f4=;
 b=IkZ2+oMXCw0bhli9ajjOy//KRKrBwLS8+HE4Maa+wGGwUQi0YSziL+56wOeFdXLi1J
 Zs1sXPFP4JZPWDoD67OHiUc1hLWN5VPeEbtw3lWhSSrlgmRFkmLMGq1s873/rHBguVxz
 U6MeLYedIHMKtzKiAzpEJB1e/EUK9AKnRKnUt2oAAIsnBRlM9GN3uUCOP9ZKyVI7er08
 udJ7PjdERPdPiIdRYKm/D6jhlV9hhgoesBeJC3IeW1OGvzQTaI5m8hGriYRxSdHWAtTY
 jLbtTm+62mUsOFsegBrL6EOKOFYfVllB57RcvAUVAoWG6XT7Qg8G9N8THJVkwVFdAmU0
 gyjw==
X-Forwarded-Encrypted: i=1;
 AL+hErEwg7TVjQ62nWkqnb1AXDZ7U7JdnJXFhnmOYRwMyc0OZ8DJy42mv5SUytiaCTlR4kSUlcaYEpAGVcQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+REZENniyLztxVpu8FT+4CePGDq56yzJVot8t1+fb9ePxvsslM
 +vqBTU7gJuMtBxafOF0uOoP/zNHNIrFE9lBNre38SUDlOo1w+C3f1kFA/NBHffeFPyen3+soCOc
 Ha4coH/ViL9ZyYVtbCW6TqCmu0ZJySeZ4Lb0g2CBl6sWtz5Vtqidz7GAQ8/Z02wyXeu53cvo=
X-Gm-Gg: AZFdTZevqUC5j5a4aW6QZ5HUFDcajb8cHCss0YhuLEo1M0WP3++rXzOem0+5OUrEXSA
 Mg7PUNKcOFNeQxjLOWurnz3WJnNS+xuEvBnY/6UEd3Vpg/Sf6Nfb2MX3H6ia7w+gclOGSYlD25B
 C6cPSv0j1nxQfwKPoj4ndo9L9jiKBPi8A0wk63mPV2HX21wHapbmskjclyQRgEwx6LV/sxNIbzR
 P4MR7j/eplM4ChJ7wVJe1zLixc7LBUYdV85t3LK1bMtKlGvqtnGKfB3aVLk+27XjCtiYoIfkF3e
 UdjOWUO2Y8LK5XrYOOyYefpcQo4mNidoMY42EcyUItSW2q0rRyLihrtGlpqfpWATxoVYOm+dopF
 3BYgtnJKLqqqpDLZQiGKGCv+Tvp1TjI1FAJNKeaKVQA59KBYrPNf+Hdp9ljiDkUC66KdnGqM=
X-Received: by 2002:a05:622a:e2cc:10b0:535:f9db:3b86 with SMTP id
 d75a77b69052e-55d769f824dmr343746011cf.3.1795681914147; 
 Thu, 26 Nov 2026 00:31:54 -0800 (PST)
X-Received: by 2002:a05:622a:e2cc:10b0:535:f9db:3b86 with SMTP id
 d75a77b69052e-55d769f824dmr343745661cf.3.1795681913644; 
 Thu, 26 Nov 2026 00:31:53 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370e8adbsm9286795a12.17.2026.11.26.00.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 00:31:52 -0800 (PST)
Message-ID: <c1ec2f35-955f-4131-85f4-bae78d016c98@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 09:31:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] drm/panel: s6e3ha8: Correct the polarity logic
 within
To: david@ixit.cz, Dzmitry Sankouski <dsankouski@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Marco Mattiolo <marco.mattiolo@hotmail.it>,
 Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
References: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
 <20261125-crosshatch-panel-v4-5-120adc58e737@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261125-crosshatch-panel-v4-5-120adc58e737@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: J5Vq7C7d_kTh94GIyYqQxyn_GoqYjkwp
X-Proofpoint-GUID: J5Vq7C7d_kTh94GIyYqQxyn_GoqYjkwp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMiBTYWx0ZWRfXy4kKzxZhNl93
 +XTvuC2a1+FqMvdJLvxFJN9oJNH5HeBObR5SfKmZDCus37JEIGCSf/6CIHrk8Ln8XKRDy8EAlxV
 Qr+sblvbOmjgm4HM08SkVKnuZJUtUoXbwBU3AgdoEFlur75Af/4Td0obr/82Y/trdoRkW7mvclG
 OB2IJjW/iIQxhr0K99jkgFtUnN0N8LkdkVFoSFBmxRqR9T2snDqTF+alvWgOGtsdepainzrLUzo
 NcDV66LDY/+lCC+mw/ScigdH67YJ8hHkZ7mneHWVTiaUON4HrNepUsFsZsmFcobTtX0Jq1pEyd7
 Vqi28KACK1QS6BmI/5Zfj5zhpVEYzKdmI4Wuvm/jS1okKAIN0YquMqFXq4oLojWTT00rI8ZSYiV
 hb4fv2Z1EXDbwFEleqY4DU24qS8A+Oioam5VGNFnbUqhCdRAyJ2qiw4JFYagHSxWrsHod7Pf98f
 dndakcReUtF6WrV1Dow==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMiBTYWx0ZWRfX3vxvLQvIhNRH
 xogts0WiNB1OncA66c7GNbCpkkBWJuS/v1rydJCWhZQ9YCyidyCYFCYfnIUutFkGD5kW4Qw1iqy
 vIiYUQNYvlAdDTWefIgW/OBdswGrn1M=
X-Authority-Analysis: v=2.4 cv=L4GI0OT8 c=1 sm=1 tr=0 ts=6b07ee7a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=7BbI1mFHGmmar5m0u5AA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260032
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/26 7:12 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> The reset was introduced with wrong polarity. Correct for the future
> compatibles and keep current with reverted logic.
> 
> Old DTs keep GPIO_ACTIVE_HIGH and are fixed up via
> gpiod_toggle_active_low() on the deprecated compatible.

738455858a2d ("ASoC: codecs: wsa881x: Use proper shutdown GPIO polarity")

made it work with one compatible

Konrad
