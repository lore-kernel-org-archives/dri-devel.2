Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5C5CA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E021810E57A;
	Wed,  7 Oct 2026 10:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LLe/B9L7";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ka6vbA3c";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5572310E57A
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 10:12:51 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977juqg2312995
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 10:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gz/WHM/OxwiBIQSq/2goRMGFNB70MAazikHbrFYtcGg=; b=LLe/B9L75XqetSuj
 d+B+g1cZfUEiuL8LI30NJH5ddWPV1YHNGoXnp2JX/CH0rJnk3QrjdTTtQx9nuzRv
 nBpxQxoz3OPWOrK6sYgGw8E6KVbAso9l9ajg1cBXuBEnW+WcnDfFt2atGLhcBtfZ
 4ByEW83AxdetcYqthiUo8a3J+maX7z+z5Suubu+BwrZa3PBwHgeN99S878m87NYk
 2purfUHvHiiqwNb9CvrZTcB7mSNMt4kAW79oOZv/NpLqh35aHpTcuMnF5Z7Ya8e/
 DGCiNwztfVCPLehM9yAFlKeP6tbOXxyHAUoqTOpzK7cvnqI4dlU3H6j6HniYS3Z/
 12If5w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h53askwe2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 10:12:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a47617a0b3so3959881a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791367968; x=1791972768;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gz/WHM/OxwiBIQSq/2goRMGFNB70MAazikHbrFYtcGg=;
 b=Ka6vbA3ckYbHyN4lAu067dXpH7274R74DYEmmcxLjIpSPuKJVGmLzdDZwAIoMvjMeG
 qIhYKp9L6DbI7TcFHyhhFrwt4Sf1qEZB8YVH7ijTzu4ThO8LMS8wNsyiTvm0WkHNBRJp
 pAL5y99MmPCOoxiubF0P7P0gUvgKoxeFS9xJvEOLowpBS85WYQVxxFRH1fTd5irqcBhA
 fMiEARkPSiaTYohEIGPmktHMzdHBPVgxHatQvUW/VNdwatIVbDkyiMSD/JJHA+lJCPph
 4T1eS0t0J/g7uXFvJhsxl3hGc/WUp0EB6olMhAAjv/fInv9kEYjVdc8STpNzzJNEXBmS
 LDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791367968; x=1791972768;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gz/WHM/OxwiBIQSq/2goRMGFNB70MAazikHbrFYtcGg=;
 b=hnXw9c64czx6KL6ajWUKlJJjaG/lD9tJxr02yrmpViMEee6PIerSpCh/2uoeWWNtEL
 rj78rqHyTYRTeZZ1CBtCSItJfvP7D/NbpCCuX4j5jurmgsyA5ZahMlxwfPd9Pouiybcw
 TK+PEK4CJ8VX3SDn09d7xl+2AI1ZwO/FLzCI7soe2m0MhKq7tjCK1wdnZUX0OuAN+s8Q
 7XtRUr/Dugstuw0kamJ/K4z1z29EXiu/M4LxFIJfRA94R8UxnZ9qe8ho7ijgS67nFvAf
 c0GdIv6DMvDXOGgZV9EI5xCcwje5w6nT1u+W7N2LqPJTntsnc7dKTkMgTZ+ZGEQdFyjb
 Sy5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwg5T6t+aylA8MVmptaIBRJTzoH+UpKbZFYvntmsQbvggG+zKg2tYw06OalCZCzLj02Ty2wS4PqLEs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJZB8MEQ9Be6Big76dsz2F1TmI0JFzBhjl+snChVIsQsWbiSzyi
 sHyZ95uxZpkwTT5qJA2/S+aSW7S21ubLS9QprxPIP8uTIOlkpdSMgEn/+9quC6ijReQ51x09a4M
 +KT2fa8/j1N39KV5t3fPqxFno/CmPJpGMspUn1VWmbeX4P/IoiMl6RQoQygOPpsAydPUQZng=
X-Gm-Gg: AYBFou3lZlP0VTMAiwJ35iJK32/4ykyTEnHOrYiqcrnJhA856Dfvx/dMLGItzZFjDxk
 bu/4jzPK/c33TQdWvo3iRLLZ00jGxeWd8jbIeOp7Gycc1hh4AsPo/vXxvY4Uc0q7QHIGKeNrYz0
 pE2iJrXObrYHYYqM/OGzgmqLlKHHNmO/QrtSVxAttETfFfPL7SIx0Q/GNYTHgFDSUJ2dH/blxG1
 iVdNSkvdhhmEUsZz/iSkJGOJPu3oTO+lZpj2xoqwGH85kkYjBg8SXZDlrSBBJHLzNiwb2SNP6Dt
 ScqdcABs2R1tgjiMrastMI0+n3Lss3WT8+RHwZBv28GospIYKyn/zd8M/oK1ySf4yMdNaeF7btE
 Y5IQ+7Q3CwD1BWviuSTB2liCTppBJ
X-Received: by 2002:a17:90a:d646:b0:3a7:9afb:78c5 with SMTP id
 98e67ed59e1d1-3a8a0ba243amr1054262a91.30.1791367967968; 
 Wed, 07 Oct 2026 03:12:47 -0700 (PDT)
X-Received: by 2002:a17:90a:d646:b0:3a7:9afb:78c5 with SMTP id
 98e67ed59e1d1-3a8a0ba243amr1054234a91.30.1791367967450; 
 Wed, 07 Oct 2026 03:12:47 -0700 (PDT)
Received: from [10.219.57.162] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a89d718355sm1326649a91.0.2026.10.07.03.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 03:12:47 -0700 (PDT)
Message-ID: <f533dbdb-8e63-4241-8b7d-0a08fdd39cab@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 15:42:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: misc: qcom, fastrpc: Allow hex digits
 in compute-cb node names
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20261006-glymur-dtfix-v3-0-44e2bc5370c2@oss.qualcomm.com>
 <20261006-glymur-dtfix-v3-1-44e2bc5370c2@oss.qualcomm.com>
 <20261007082515.xmjpa5jjptgrl6y6@hu-mojha-hyd.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261007082515.xmjpa5jjptgrl6y6@hu-mojha-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EG2HeTmf1jOb7WiZpKy1-DMpXKECEeCr
X-Proofpoint-GUID: EG2HeTmf1jOb7WiZpKy1-DMpXKECEeCr
X-Authority-Analysis: v=2.4 cv=Xt5vqlF9 c=1 sm=1 tr=0 ts=6ac61b22 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Hgre0dTw_wgs37D_MzoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MCBTYWx0ZWRfX83lSVMNkK8HT
 6PQB3cZ7PeHrLeyVG0M1Av97qICqmwE2CJsmVNwO/rfZm/duU+BEX4dAxq5ry7fLCAfOKlpJQWu
 ONKtn0sH+9OGHuDtgCxJ1Wnzy3Bd0MSpFUV+WXQF6grA553E0gHWAlVhn//y9vx8ziFtmhs9xnP
 YB/N+cFqwlvNL67y8hGAGnHjN80nZX3SatyMOnGjBcQsEsNaGJ9TvkvgIm4oEUUYaIRkv30/An8
 smqBA+gIVeHOnkdXxhYAe05t5lzgr5O8X1WC6szBjY1TNFaZF4oW0E/DIgbgUr4/3RI8oM7ajq/
 GyfV9znCE+6BokSjJwVdYesdhPL1Cn+QXTd12A0tmFZiiEhOgucGuJVO98AZW29OXjx1yJEQENJ
 yCBGZ88ACCQ2GdZaaZEPBXDFf5LCoEQdTS7+1Ft5JR6QtbQZ3yVW9poKHcopwRzbD4XrZ0rDmqe
 gaOyhHYILaYxHBFEWmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MCBTYWx0ZWRfX97yhYNeaZNq4
 VjU8wYQVUEsdzVpafdmh9ZpsQn0TpyC7BD5LvVygKI7wWWiiMJn+/qcrX3TFkVKL9KTbQnkOfaM
 nobyXbNQkieQwYWsVjUHyKkIq8GAhkk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070040
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

On 07-10-2026 13:55, Mukesh Ojha wrote:
> On Tue, Oct 06, 2026 at 03:56:06PM +0530, Ekansh Gupta wrote:
>> The patternProperties key for compute-cb subnodes used [0-9]* which
>> only matches decimal digits. However, per DTS convention, node unit
>> addresses must be the lowercase hexadecimal representation of the reg
>> value. For compute-cb nodes with reg values >= 10 (e.g. 12, 13, 14),
>> the correct node names are compute-cb@c, compute-cb@d, compute-cb@e
>> respectively, which are not matched by the current pattern.
>>
>> Extend the pattern to [0-9a-f]* to allow lowercase hex digits, making
>> it consistent with DTS unit address conventions.
>>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
>> ---
>>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
>> index 49d2a5e8ba39..14fed91fee50 100644
>> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
>> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
>> @@ -79,7 +79,7 @@ properties:
>>      const: 0
>>  
>>  patternProperties:
>> -  "(compute-)?cb@[0-9]*$":
>> +  "(compute-)?cb@[0-9a-f]*$":
> 
> 
> While you are changing this, original change had * which allows
> cb@ as well ? should we make it to "(compute-)?cb@[0-9a-f]+$":
ack, this looks better, thanks>
> 
>>      type: object
>>  
>>      description: >
>>
>> -- 
>> 2.34.1
>>
> 

