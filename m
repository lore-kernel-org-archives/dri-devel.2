Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886CACC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD45510E4FC;
	Tue, 13 Oct 2026 10:57:49 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE9510E4FC
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:57:38 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8VIl5302945
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tSEpmU69diOtyJsEu93q34ttA2iL6Hvw0WchJvAmD5o=; b=I90/xmiCWR8WibwX
 oOgEZXTkzbFZSo65c6ZLMdeB7caCxJnWtUeLDHUOk0gBOrnavgTaEQ6wZSqKWPWb
 fll6DD/vpCKecwKQWcZoSbTCOgccG+61qaieV0V6/b81BLkevNKwlWqIrAciCO5a
 yA2Hs2RkhuERSOXAX+ZtCVFzG7+t5nj+UcjDYqJt45CEzAzisyzpCtb/bRQw8A3K
 W33c4vHRDttJPxG0JQ3p3ztQC7qLuP/p9d2bOePEMI3lTUzig5OXSm1+Sg3x5f/3
 YRnUNXNcI9AbT9BwDFdYZeKZ/fTcyBp1ccjvCBXGiexNGaqoazdSfBPfTgfM7riM
 aTLgNA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98sqaghw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:57:37 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5338a4075d3so9941961cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 03:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791889056; x=1792493856;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tSEpmU69diOtyJsEu93q34ttA2iL6Hvw0WchJvAmD5o=;
 b=JN9Fk23AQcBmTrde7MXpfuhFarftslri+cdcAYNvqvIaxXkprr7TPEfeAinmc0Jhgu
 IDJ2m7sXk6ukMGAACQn+ZVl9xbhRC4X+BusSmKIATj0e+ImkNmr7yL3PoaoLLSmWEwoH
 7jY2Ssk/oQbgOJrxe6weTRPKgzO7m6l1E+CK+6En+ddxj+YEw8v2bwwkbCdMrC6lMRca
 0xgr78SWi74ITe0CSasvIJLwUVufKM8miHQa9MFka0icKDbqZ1FXRA3ZTO4+zC3pley0
 6wEqKnDOa/8UDr710KzTcIl3x81MhWQ2UQpZ+8DRyHqMfM+MEV89XhCbb1zB4vSsiNZR
 Wkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791889056; x=1792493856;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tSEpmU69diOtyJsEu93q34ttA2iL6Hvw0WchJvAmD5o=;
 b=a6Bz7Za96XNsAivnjZXDQDRj6jwSqdt79Udf331TswMZ5/jlvCAxvIvPum/in40T/R
 NWQlSA9mtuykXi0TY3Ajvt62v2Xf7itHP8fqtPXDyu+Rm4gpISDSLRO8cLfysx0wCY6S
 ePaYs8nkuBALAMyr1tLBADKIIgAheht0TwytVEQWn88dZLpnZgxldU+gac3nH+hTlpuu
 5NXUTmhQF34F//I0w+gjaNlyiG2wya64oMECM8MhXzWLHEGdTgIZq2WFPqbVC5orJHgJ
 HGTTr8oCENSdRVq6uuwivyZs8IGNuv0MAHUyE6R/axgNRPWowEJ4Tu8zHxP7H506CCv2
 kr7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbj4upG+Uu3cvH0gv+e2PaRxPODCrpF4PhYeCmmkv9jgPaP2R9vHlrcJN0FFTYanfjrYv3JnA2XrI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLX9W6kJRqnkQvVdUnk41S8Qbtvx7AFiTnGXPtOlLtXLONweark
 ExWDJYUNpiU3V0rb5QYzCT7OhANeRs06qX4G+WO6w4A7i0hJ12hs2GKAQM4HF+Z3dV9BmYKWs9e
 8sdKz/VI+jA301xRXCM76wi4iwqmHDSFSWsMIIt7tgLZJVdATc4S1ZRO7SVvPgMXidGq7y0c=
X-Gm-Gg: AYBFou1m1BmteGzmiYRR/ceIX5OnI57SaqNOechDC6D+Ttbd1FAzDOErv/WPdra1V3Y
 DMUNQ211P4SB4o0qJ6BzUfBS2DQfI4GxRU1HfjIUn2YBJyvHdBHOsAKEmDumauq85A64qxKdfuo
 mZcTTEDejlzSvpF0hZx1kMTM4+Vp8D5JACyiZo0M+AGY4mNjsAIAhWQuw61xRqqZJAsmf9t3BXI
 9j3b1E4oqLSpG+17avRQM06cPcTC/r5WHrKpCvGz44I1rVNP4N2YhBZRVNyT+8v44myuQqliSfL
 kWyWMIBX3D32cPsoQaw1B1yjdqZr9IdEir7bP/bS3yicySQqVQcTOr737dx8PpDtssnj9LdT1Ec
 EicjdGWhwibQUF1F9q86RAw==
X-Received: by 2002:a05:622a:586:b0:533:96b4:8dd4 with SMTP id
 d75a77b69052e-5359f4965eamr243719111cf.1.1791889056366; 
 Tue, 13 Oct 2026 03:57:36 -0700 (PDT)
X-Received: by 2002:a05:622a:586:b0:533:96b4:8dd4 with SMTP id
 d75a77b69052e-5359f4965eamr243718701cf.1.1791889055675; 
 Tue, 13 Oct 2026 03:57:35 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c36fa559721sm67647966b.56.2026.10.13.03.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 03:57:34 -0700 (PDT)
Message-ID: <9067a9aa-3edc-4139-9310-977a9a8cd793@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: glymur: Fix fastrpc compute-cb
 reg values for cdsp
To: Rob Herring <robh@kernel.org>, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Mahima Bhattaram <mbhattar@qti.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
References: <20261007-glymur-dtfix-v4-0-31f7143e759b@oss.qualcomm.com>
 <20261007-glymur-dtfix-v4-2-31f7143e759b@oss.qualcomm.com>
 <20261007204549.GA234290-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261007204549.GA234290-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MyBTYWx0ZWRfXzyfDJTttA2y+
 4gR8M8+CZwjkqwZ3LgrAo6fMK0PqInDWuFXb9lmtzv6dMFuct2EFrSBm4a8LpUduAvFnbQ9KncZ
 4+7GXjK2Ss8H8M4lrcdQYNMthGlckh9KoKn9FymL1vA1COCAVVcdvFnpRYU/8h474Q+QMlpB7PT
 okXYSaVkLWtFQEmxlrdVig/XLBaO3eREkgcvMd8oYuUx4cd6hWenrgEYAD85X5FNAKy/ci6Z7Sb
 1bjkVS7yRp++vyzaN7YViBwk0MqSOXJOw8oATZyJaWU7EroYYxBbPIIzI28mhYjaufW//IS4TkZ
 RkBI6T/SNWL6wtwkrnNmubyxlzDKM3sF2utg2LbDs0YD4zVsIsjyLwbqg5gDqE7uM1PmVUSFhQk
 4Oep1qWW9cu7HdE8I2vt8kja6FU3MTV2HClw/4SjMysVVkOuNHT7jLnUKQYnAJBcl04BLdYT4ZF
 UwFVPt9e/NGx0upm0og==
X-Authority-Analysis: v=2.4 cv=JN+uIMKb c=1 sm=1 tr=0 ts=6ace0ea1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=SYeg_LyZQ0ZiSJgYx_IA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MyBTYWx0ZWRfX/G2Ldl7S6f0q
 jdqDpuKXKlPtp6IQ+O3k7xKHi66WC+hd0GzSLPw+RLq9Xwgdvs2Rb+Ayh3x/Wzd52B2mWb+4k8P
 uBfTyS56fR6vTGne2a0U3pe9Zbzv6Dg=
X-Proofpoint-ORIG-GUID: byISb5ty5ww0uXwnZqAnS8PMQYa3swWm
X-Proofpoint-GUID: byISb5ty5ww0uXwnZqAnS8PMQYa3swWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130043
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

On 10/7/26 10:45 PM, Rob Herring wrote:
> On Wed, Oct 07, 2026 at 03:51:18PM +0530, Ekansh Gupta wrote:
>> The reg value of a compute-cb node must match the SID (the lower
>> nibble of its IOMMU stream ID) it is associated with. In the cdsp
>> fastrpc node, compute-cb@10, compute-cb@11 and compute-cb@12 were
>> mistakenly given reg values of 10, 11 and 12 instead of 12, 13 and
>> 14, which don't match their SIDs and leads to SMMU translation errors.
>> Fix the reg values, and rename the nodes accordingly.
>>
>> Fixes: cd1d174c75f7 ("arm64: dts: qcom: glymur: Add ADSP and CDSP for Glymur SoC")
>> Co-developed-by: Mahima Bhattaram <mbhattar@qti.qualcomm.com>
>> Signed-off-by: Mahima Bhattaram <mbhattar@qti.qualcomm.com>
>> Reviewed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/glymur.dtsi | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
>> index de7c395d9c35..3219603372ce 100644
>> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
>> @@ -8471,9 +8471,9 @@ compute-cb@8 {
>>  
>>  					/* note: compute-cb@9 is secure */
>>  
>> -					compute-cb@10 {
>> +					compute-cb@c {
>>  						compatible = "qcom,fastrpc-compute-cb";
>> -						reg = <10>;
>> +						reg = <12>;
> 
> Normally, reg is written in hex too.

+1 please do that

Konrad
