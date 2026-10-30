Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA32606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RWrRr6lY;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d+bfjVoH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72FB01126DB;
	Fri, 30 Oct 2026 09:39:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C14121126CE
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:39:34 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U8F2Sw2134509
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 urtOggJbUkGw4tpoKTxZdedqljv1BLA2Q2uuz8oB09k=; b=RWrRr6lYaahDYwc8
 dAeWhIyeIqJ7u+wgKrKjWW6fuVo9f7ZInfVbLhyITDORMvlGYrDA8qlrtACNtD7E
 yz8s7iqTzpgzT9l4lLabTxPJDQEPvcBapWbbDNyum5yyYyKcgAqFGpYfQmJMltCB
 HlamSbXS3xEZfvZN3vq1eaQwCAGderXDodph7sv7SMPLmz0vmGr62Y69ymAOyvNI
 BbQ4uc4xxntHkNwHwqHjClnDjbRFsNr7B6XiFlV+FP0XjAjk/GHRQRv45isNXdO6
 oziz65z93uMBjG0tWdIbK4v7NXti646wbPVG7ad5MXPjYlZbEfhxZGXIMfvwDoLX
 /qKUfg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qj8k1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:39:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so1483548eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 02:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793353173; x=1793957973;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=urtOggJbUkGw4tpoKTxZdedqljv1BLA2Q2uuz8oB09k=;
 b=d+bfjVoHFv3+6JYlWp9tlA50ZSje0x4Alo4022EgeLZets6tn4RlVcmuP5P8MORDIm
 fi1GfKugngq0no3mD3LCaEBFBYtLi9Ugk1tjXYFVJOtFDB3lmnaGbdh5sm26bxu3eOVH
 L3B7TLEgQhEUlD19fou6IdU+w27HOGMUOHc2wmNYL1wS5piVygFXw/ltJRZz8DaNk+OC
 qQySs2BrY2v0e4s6fL53deqHopsvr5RYttYykwybEeNQVuE3jPgDQWZFUzA/FLScLyDI
 uqD47f+qZ3cGfToMj+ZtMRP1dWVVND/9pEs4EOUN0Jsq1jN/K3qlFMaGQhHoa320Um/F
 BiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793353173; x=1793957973;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=urtOggJbUkGw4tpoKTxZdedqljv1BLA2Q2uuz8oB09k=;
 b=qvw3Pddqkz8v29DVcZ7vW08Xpds8XWyfoamakeN3/9QYpwX4EthOUvTMe480TlInHR
 kMrCCAhFh7McV1Swnl+XrfqBNDP+mH5/+/o/K5iOl6MIhkDbt+z6Q5jqWQcyr+cwwHSo
 hM60TyWDkLmIib8H5et6pMAtger9M7eHpyIDeAZXt8NP/WYGagRKiUhUYb3bJYXkIyn6
 DuQM2C3DCbXQBwLqevdjBonFN87m2pAMmPRPFcQXEYDMcaYSk/GioQ5SLUmN51t0Pp0/
 IZX2oXULqgesQajccqHJf4IsKZfBpEoE2eux+t1XVCtstOcJWGY1m4dBIlc9FIxC73PO
 22Bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwW3SKlGPdk4NsjzMAR5QacGbQWEJPc/7OmO1Dhx+0wnY6IWep8ABRQRYJTS4sIngpJv7o2WAyqBus=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKqtisVipqq4BLO5zbSOC+Dfq6cQi1Ynh7FKCl9ij/pKlgXEC1W
 lusv6GH7a9byhKPKGY0J9F4TQJWLvjE1vpanLcLziEBwS1RVXcjB97ATMfE5QmuqEa6rsT7kkbw
 J76kyQ03iIDTqMemzN2+VotYMNzxIvSKThgnnFMhWryANdw00sxSmTRiRH0OOZTgICjbihmQ=
X-Gm-Gg: AYBFou20SyD39cI3wRIlQEAMi+BOqVRkatgigRFksC79MyaFUkszLKrXFMzgwQfr1i7
 Gk8RZjsBE7fUXqiTx3FC3PgzSPQSHXk/Bp9iKtxB9KLiTmUSB3iROF89ZgCNZ8EAaAlzFOXR3Gb
 S6oDwiOoIwxkSAMTL8GA/Bt88UkQZ/mpqnqvz1yi3jJMDrHdRGF47PN5yONZAmZf8s+zbWBJOll
 acML0u3u/vBKfBAboC0zMvHHEBHF28jFItkzHRfNu9+o7U/eOYChYhWCKOgIPxmg4gEFdBX2jkE
 SxMyefCFes3JJDhJlTDKKD3LQZEdgCnlO98AB1T93eys68NaVG5kCDNtBovgQWFpa+Tix7ufXwq
 WJF/6MzYSLZBCzfj0qcRL4JlUV1pPYr8d83aKiQ3hTV8G5di/lWir0aJWaqqeiMxXs8vd1suNH2
 WxN5Ji
X-Received: by 2002:a05:693c:41c8:10b0:367:185e:867a with SMTP id
 5a478bee46e88-36a4242366fmr2925513eec.38.1793353173391; 
 Fri, 30 Oct 2026 02:39:33 -0700 (PDT)
X-Received: by 2002:a05:693c:41c8:10b0:367:185e:867a with SMTP id
 5a478bee46e88-36a4242366fmr2925463eec.38.1793353172638; 
 Fri, 30 Oct 2026 02:39:32 -0700 (PDT)
Received: from [10.219.57.214] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a98f65sm5716667eec.28.2026.10.30.02.39.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 02:39:32 -0700 (PDT)
Message-ID: <2e26e864-1f17-48b1-b84d-17057e7a343f@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 15:09:26 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: misc: qcom, fastrpc: add iommu-ranges
 support for context bank
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com>
 <20261007-extended-mapping-v2-1-5dca3aa2c2d3@oss.qualcomm.com>
 <20261009-space-crane-of-prosperity-bba4d7@quoll>
 <1276435d-7102-42f7-ad92-84c61aed6d2c@oss.qualcomm.com>
 <30044b8e-cd81-4798-991c-dd2e7ca6d502@kernel.org>
Content-Language: en-US
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
In-Reply-To: <30044b8e-cd81-4798-991c-dd2e7ca6d502@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzOCBTYWx0ZWRfXz2iXFduxFyRN
 56y1D7dtI4ojPw6XFhw6NwOgnAuS90m/+p3YraeX6R5CiVbwiOYUr5kehHsjXFmGpu5blJa/myB
 by9otf0njKmFYxUDrJ9LZq5hAuhtzdymB6jGqQewzromKayk2vyv3nfgp1L5C60uNoygLb2NBm1
 gSFEzDaVpn3ZDrj2R/FG0y4hK5LX1fHHWairj1xmIXbXdZeZjOe++3VjTsUjOloU1HJjmYL9Zp4
 OiRLdKWzT2jQMyJEdoL2i6qv+1lvbcRwFLW1J3Kk0HaWt4b9Uj6/IaT+wMCox2B/AlZRhI1bw5C
 1oG+ZeYmy9TIBbsBgJ8mo2JfjWr+hLUmhrFWWwynj4nGbCajkvqBZFxib4H+3mz6R0CVQW1c8sk
 ufhLQzNZtSGGwdIuxrVPgAxGDlvW5Vlbf5VeblaMt8CAiv77OXUBEMSyAxGyI8Ino73+cWotvjm
 VWnsms7D4DBqQzi8ypQ==
X-Proofpoint-GUID: NwF0665rJfLUNlTabiI4R1MNUn797zPa
X-Proofpoint-ORIG-GUID: NwF0665rJfLUNlTabiI4R1MNUn797zPa
X-Authority-Analysis: v=2.4 cv=IumL47/g c=1 sm=1 tr=0 ts=6ae465d6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=iXeEQ78Lhshhe8WC178A:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzOCBTYWx0ZWRfX/UZOB5gGZXzL
 ORAuc86siyjDIrpDhP0Ro78clBDmh8zj0attfTXMJUX7lewocwRJWtH67Ev5RnYddIH0Xj0queX
 t9NLt9Es+PlgzMjDEgtH4H9W7m9fck4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300038
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
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/2026 7:57 PM, Krzysztof Kozlowski wrote:
> On 27/10/2026 14:12, Vinayak Katoch wrote:
>>>>
>>>> Relax #address-cells to enum: [1, 2] and #size-cells to enum: [0, 2] to
>>>> allow platforms that require 64-bit values in iommu-ranges to pass
>>>> binding validation.
>>>
>>> Which platforms are these?
>>>
>>
>> Kaanapali onwards, I'll update it in the commit message.
> 
> Then why all of them are changed... anyway, you responded two weeks
> after comments, so that's only fair if we also review in two weeks time.
> 
> Best regards,
> Krzysztof

Agreed, relaxing the cells for all compatibles was too broad, and sorry
for the late reply.

In the next version, I will add conditions so that the 2/2 layout is
accepted only for Kaanapali onwards, and plain "qcom,fastrpc" stays at
1/0. I will also update the commit message and add the new example.

