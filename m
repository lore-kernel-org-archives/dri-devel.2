Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCADCC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9B110E782;
	Tue, 13 Oct 2026 08:40:11 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48FC910E782
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:39:59 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D7OXVI015278
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eNL7vgR4kDGeD5fPFGvpl05GH+Y/43WiLVBF8tPpz6M=; b=nLkc5y0XQPFD1mUJ
 sysjhMEBmQzsIDnt88JYqviIa6WrohOk1363fbZxP/QS/1rxks4/NQfmxFh7cEfy
 OUeaERIGqVFR2kukDs0FbS8IP1of8lbUjfO5jd1cBFdZCNTI/4OAniUq1MRoFmTb
 Dm4yCrW8faLWkO0iNXi7c5t5owEFnW8NA7G8ia3wNGz4JD2oYuN5Wgwgt6IC2kkT
 uy7hexJiVGkzPheO/Q3EngoHVLYwrK+jYLhcNbci6dcK+FyA9yANYYBlp1p5NIVD
 6Hv54PW3CZDkoWyjVKjcJcfUSQIaBZDosq98vnI+6ed/pgWGuPZ93oiesKvT9lgC
 Fc0OhA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9g7ug9tw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:39:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93dea15d721so27020185a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 01:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791880797; x=1792485597;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eNL7vgR4kDGeD5fPFGvpl05GH+Y/43WiLVBF8tPpz6M=;
 b=aweyxiN/Wm3sFMuUet3PfRPGoA1U+CiPJSQA2IA+ZOaYfJIGkUA9Hgu641lthVPVFe
 gk6ccJxC6zigUJ6UhjKkZHgXcxIXuIZ7kOOd1QQ40MACNPBdDKRnAiU2OIeeGEs90coP
 /5N1PeO37XpISsmTkC2tvdGuixNSg/J/5S/Xctoo+/tvkazlRJWM4xXVlfsHYQhs7BDD
 0EIXSOkl99WNlS7wX1aQMV0G8NrQjODKf4+Z22nYSnN2S8EB6KJyYB6zCB/THLoqBA7C
 21mZ7KmL30/jkJa2X8KH9WR49W4kaWTCAuH9M+ovxo5QBuL2VEqU8A9pY036ZLxJWrdW
 wYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880797; x=1792485597;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eNL7vgR4kDGeD5fPFGvpl05GH+Y/43WiLVBF8tPpz6M=;
 b=eH6pWkJd259wBFHoLhgeCNKBCR65S52YRI8sHQtMsfCJHcmYeDI/j7WvnB1LzoKc1i
 q0gcO71ieMv4Bcvxoo50XhGxeOM/aEiwhWNPgAc1xLIb+6qcwKoy5ea0P4gNk5+/LSXi
 /JVXbHqF2+byFXFoQWxXQuty67qnWW7Xd1RKiteZHnvI+BR3Bp/Dl7jFvRcl00DdgjW3
 RBRSdfYVchrGNYF1qopUjBL3PrlJ0cwPqe+BcunJ+bCypqcWxBF72VN/r+OATsMmn08K
 48Hvu6iMNHbh4X4Eie67srnK9FiuTKGhudgArw/b0OKRYkqukFB/jC+h22EzWq9/obyY
 80zA==
X-Forwarded-Encrypted: i=1;
 AKwUvByK36dwBm3eABR1dS/AvCXvP/gwqNNZLrDmWfPGEfDTcRs5vLG5ajcR1ddWb58VSjsMPgA3owdzocU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLlgdlI7HIFrgXNDOrfW04c0KTpKN90YfxxrNUBheOBForbnV4h
 NhgHPC8S8JBq2Sg4p8ER/qmxHw/Rcp1zcpiuP8QTu4h9ME7/N8nwsjyk1ZU9Uu3aeUgW58WT8dc
 ggXg3uafxt1pXWDjiQCJVGdC+S/YgjTGVFqB2NbzQ5Cm2D8lzP0XotH2VSozxK6y7iLLuX98=
X-Gm-Gg: AYBFou0R+cU4SZYqflIiQ7w2zxwASoe4i6/T5A73ALaHohESGsV3M7BDJ05OELj9TbF
 6yx/2fV4oceR2qnzsY1sp5LPH10ssFKSOARIM6vvbXPcTm5gpIlIQ/ZJ1N5H1qbWduIRBAtGxru
 1DmN9S95wZvFdzl3zFbbrlBaPGdzQg14r2JOCndssjM0Qol8hsSXSEZX2V6mFn8A0gr/JONxI31
 LdFHcgLUKAJ+2s0QXo83v+zRPoNVVi0+GRYsEwFermgYzpGI70DWhZQLONnxfQoKCYuQZ9I0FsB
 IydTPrVvgzQ7zTp/4qGYVtfa51xkP8McLE781dCEKjlpN6eHg98ooasXQCXJ7KYBAi7PZ2lMumh
 L164GjS3xu1C18dxsUWWbFw==
X-Received: by 2002:a05:620a:8084:b0:93e:571e:94f0 with SMTP id
 af79cd13be357-93ebd1eabeamr2187959585a.3.1791880797438; 
 Tue, 13 Oct 2026 01:39:57 -0700 (PDT)
X-Received: by 2002:a05:620a:8084:b0:93e:571e:94f0 with SMTP id
 af79cd13be357-93ebd1eabeamr2187955985a.3.1791880796886; 
 Tue, 13 Oct 2026 01:39:56 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c36fe6dbc61sm51688266b.30.2026.10.13.01.39.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 01:39:56 -0700 (PDT)
Message-ID: <52adff3a-370c-4445-9797-e0b0dde36fab@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 10:39:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: arm: qcom: Document Microsoft Surface
 Laptop 8th Edition
To: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maximilian Luz
 <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
 <20261006-mahua-surface-laptop-v1-1-406fc042162a@oss.qualcomm.com>
 <245e5eef-e18a-4ec5-b57c-65e561101351@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <245e5eef-e18a-4ec5-b57c-65e561101351@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX1InBqfGRSnz6
 Dtdqg3RwLmAAB7CyvZ9GCgsuFlId4PvuCasp5ERr/VCxygFZLLalOYpD4CuuLLdAivGwlsPCpqX
 aoykGyZJghCJKOMoEL7IP3Enxh6lYGRoeSr+HkZ128KRNvlic7s5eO9a98UXHdCvHCZVh9LuaSN
 HaDHPvpHUMgjiuxEu9us4bGtSYE9Q/bGRp2KXXsNHWCWki1Cc2W6+wuk/Ti4f/YhXumkgLw/qIn
 mVjbD+SghBbV/1y1vfh3+QTin4YLWkOXW8XrZWdIuSE1dtFxTZrxBXXvEfZZNTN0w5ZH3scSwll
 tbnkpVGRJSGau77LPS308fDQn5snFd2nQfhtGzfrWjOkmV09ebwfeANn/f9r03ekfq54apPZrXp
 Scsu1xfeTWW6heFtOtqSxDLdZ6n/lCF1cq/uMK+WVXVVSwXxZpQar9H1LwFw0ThNdz3gtQIi7W0
 zH1byFX6/gWwsZ9IvEg==
X-Authority-Analysis: v=2.4 cv=Z495j3RA c=1 sm=1 tr=0 ts=6acdee5e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=rd0sP4ULdwr9m3flnKMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: ZJtWT69bvT0IZdUSraPRE5RdKvzmefsO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX1pCxtWcJoSMm
 B6j8xVyrXfm0ZT0hhNBxbDfoamwkQScP+SzS0qLsuuhRK0TLVkJmeJalGo6EBUvPpY3pQLFnWQO
 429afgIRe2k7KlcnOdRmZeLfDsfQyC4=
X-Proofpoint-GUID: ZJtWT69bvT0IZdUSraPRE5RdKvzmefsO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130034
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

On 10/7/26 9:11 AM, Gopikrishna Garmidi wrote:
> 
> 
> On 10/6/2026 3:20 PM, Gopikrishna Garmidi wrote:
>> Document the Mahua-based Microsoft Surface Laptop 13.8" 8th Edition.
>>
>> Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
>> ---

[...]

> Before review, I'd appreciate your input on the naming.
> 
> Surface Laptop 8th Edition comes in three sizes [1]:
> 
>   - 13 inch:   Snapdragon X2 Plus (6-core), UFS storage
>   - 13.8 inch: Snapdragon X2 Plus / X2 Elite (Mahua), NVMe
>   - 15 inch:   Snapdragon X2 Plus / X2 Elite
> 
> This series adds the 13.8 inch model only. I named it
> "microsoft,surface-laptop-8-13in" (mahua-microsoft-surface
> -laptop-8-13in.dts), but that clashes with the real 13 inch model, which is a different board (UFS instead of NVMe) and will need its own DTS.
> 
> I couldn't find a codename for these, so I can't follow the Laptop 7
> scheme (romulus13/15). Could you please suggest the naming you'd prefer
> for the compatible and DTS file name? I'll update it in v2.

I can't find any. The LLM suggests the 13.8/15 in codename starts
with "ROT" based on the INFs.

Konrad
