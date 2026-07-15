Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE1FC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 07:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D15210E130;
	Wed, 15 Jul 2026 07:31:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="flWivHx6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a4ZNcNbB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C259D10E130
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 07:31:12 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66F3lHIx2621111
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 07:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eVZ9ZigYCDlcDM/PZqVHEcpbio13v2AmIbxFezgYnAc=; b=flWivHx6DSNcEF4l
 3+WFGI5my90RIuFOWmXAH/VxAWTSY25H5DEk9L8jww59k0gz5NqgLobeUCCoRnPL
 hkVQWT2o39jdqbcaCjhudF01tzfSHGN+5+Fbp085SMJBeA5O9X5/il0/a6UU+JfF
 tFudpmaESNF+xHLhdbmvcYn7CS7pDJQJjpTGmwNQWk3N1aIbzWTvTKUYSBTPAs3q
 5p462r957NYRZbi7tD/hlVGkw/zqcastK20VjPhAxYz+1eWdIBQl1FaET4C08WPo
 5hVkFCG/XSgBf7Hhg8dVTiIG4IZsvjXhrSWwMu7ZFbJqrgjdtNA8gwVI40dshMNR
 /KwPAg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe03vh58c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 07:31:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c27616421so17482821cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 00:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784100671; x=1784705471;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eVZ9ZigYCDlcDM/PZqVHEcpbio13v2AmIbxFezgYnAc=;
 b=a4ZNcNbBNDbgW1khEFeMb4FEitlp/7tIrFqpoBE2oW8oD9ekdmsnkUuecuArvRQ8Dv
 6GeE2tmh7rbxuZ0RZdQPQXobl3KwFOr4uzeCEEnwmDe9A0zNN5gjQ+vw5mLPxmTOtMOj
 kY0KsPXJAWgfJgU5yj3SFQn3BPkx3JEVWF90sNC/1cDASoJ+NSDTiE6KrbXi175UQ0Xw
 eY0twSTZmcYpHeflg/EyWxMbmMg9jRgpRSp4lDKgipp4uB2Oh8LVj1zWT9xTKThBUySc
 9l3Scqsd0BesCofErlOXm8KFhKJ7rZKvo1NnCiYj1Rl6hh3EPKsZ98zB4t7PA/GuZOtd
 RntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784100671; x=1784705471;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eVZ9ZigYCDlcDM/PZqVHEcpbio13v2AmIbxFezgYnAc=;
 b=Uq6UPtg1Lj+IZPTNy3iBzfsmdt2OTKMBraKhEyBV2n6y7XmCs8xT0O3EiXw4nHrkf0
 gAzUpPIcVkaTedgYsgauIO8PMAsTxnKjQZThiKtwiWAdSbllxmxIyRrYDVaTmjX6b84v
 SRLA8nrIo2S3q74FYJReA5UiRbeuIXVbAst1CvCF+l+xtcZdE7uMrVC4UPTEijtEfgF6
 klDtZ3Ebkbf66+XqXn47fSrtQRYSvgQFsX/ybZDMvk8i7tkc1kVkXCiwKRlb/2nqhiVw
 KHYWVxNIzc3NkSh5KERI7FGncaDaWrnm1qfnvLf+Nq/ZpwwXTS7/eZlOfuI/hA5m7nHb
 qwjg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2bdZ7fFis3/ViubbgXM+JFhh5hayPOI/Fc+/pJwxIMRyzmVkhgy5x6Df0DdZFmpYegKBpx3tXQus=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/jtTdO3BgDiKoxkkxOQI/bNzoBSrlTEX2Kprk9zQF0Xb9qx1A
 HYHP/C+qJ9I+CxhibmqRYcH4+yPQCREMR/S8iTDJkQv++7llRkjLetNotG2hnMFfVIvsh6HLn+Q
 mnliksflDwlH0ENvL/ZyRcIvGEvKvcEybYL4ZZrlqlHxeeLSCp21wCPyFgIUgGZet+IekMWE=
X-Gm-Gg: AfdE7ckDrHeYjvBVYoKWozlvSw4SSB9KENzIvQbZQTWVMFZqMYiqVdch/0ixtitK54t
 g5kRwW1V2lvJNxt/wn1M3b3GIwERa1HCKryrDPoFIPaws6af4bWEdAjWAFrfDAq3a47ju463sYU
 SufcuktjJSc3hckCjWaSP/DgCw9ea+OQCohqyH/hCIZFi0nfT4DBCMb2nbiro99WQyCbWNQBUzM
 Pse2yU7exe7fwzJ/c4Paa77OP6aM+vlxDEFSxejfPMwH0BVemdPIT2LutlwmiSlZZXqNrwU3aab
 KWZNmuW3vLbQAZ5VSAsUMHyauWkrph7mNt6cg/vC5PLcEXYmx/2nCKQUlSb+Nl1CM22+m85j1UP
 sWcv8NDokHAwN3CsIyYk5J79iUV1c+B8b56s=
X-Received: by 2002:ac8:5d4e:0:b0:51c:1744:edf0 with SMTP id
 d75a77b69052e-51cbf289286mr135432371cf.9.1784100670976; 
 Wed, 15 Jul 2026 00:31:10 -0700 (PDT)
X-Received: by 2002:ac8:5d4e:0:b0:51c:1744:edf0 with SMTP id
 d75a77b69052e-51cbf289286mr135432081cf.9.1784100670440; 
 Wed, 15 Jul 2026 00:31:10 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15fc29937esm790840866b.22.2026.07.15.00.31.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 00:31:09 -0700 (PDT)
Message-ID: <d6cbf1c1-9af5-4c06-abd0-0617dcce0bf8@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 09:31:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
 Aniket Randive <aniket.randive@oss.qualcomm.com>,
 viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com
References: <20260710161056.1799019-1-aniket.randive@oss.qualcomm.com>
 <e53ea721-bcd1-4d8f-9b7a-ea6ec3003f71@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e53ea721-bcd1-4d8f-9b7a-ea6ec3003f71@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ife3n2qa c=1 sm=1 tr=0 ts=6a57373f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=lLXzRi4vikbFFa1iuNgA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 6VoaXMBSfvdv8KnH9NgkzPh6vcbE-p0h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA3MSBTYWx0ZWRfX8IsxgRbVAzad
 q+lMXfCfnLISw5cleCQ2xQ4Y/XhZgtd3vORPJHg7bq2cR2gZpmcz+6Bspl7yPShBdTzBkU0psSs
 ECnbJCrjbN/ftIh79ey9J2uofIK+z2CvRgEOupoRStlHuxqTftQlkUTich1tdI/LR202AqER9en
 PRAB5Wv3S1AFPuJVNIWH+f2lYJOQrVd0aZH6Lvupc3qZiIJ7v1wwpY8ahrSwQ8WZPjLBHVeqto2
 n6MZOw3Gia/AzNtpun37kigcHktJRWWDnifGaQcRa5Tx7fHOtmaVLbPMx2+TcBrPrfSIajGpswm
 2/AKCCzvKBHQ9yy6VsPd1z3Ofn6PUTWWFUBkBz/lKUNCky+PhGRMfL6smjUP4FMXkMLdztRuu/E
 N/u6N5786phhWEVSeBiybnPWPdbhR76r4g2udxr/r5xyx6oFmWiAGQ93EWCKp94iLgjPQj3gmmP
 bPDpvrcYuJpBvH02MGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA3MSBTYWx0ZWRfX3A6rrOz3Iye/
 oJGTuru+r5rnqDoJYv5hLOZwtinLeBR/aEhL85thI0rD62UdQdBALbZA9oH3FXK2SSiIJJtu4m5
 LkFbliU1hMK2YktSYWu4tdLpWPshQqo=
X-Proofpoint-GUID: 6VoaXMBSfvdv8KnH9NgkzPh6vcbE-p0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150071
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

On 7/15/26 6:06 AM, Mukesh Savaliya wrote:
> Hi Aniket, Thanks for addressing previous comments.
> 
> On 7/10/2026 9:40 PM, Aniket Randive wrote:
>> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
>> regardless of message length or bus frequency, causing unnecessary
>> delays on error paths.
>>
>> Compute the timeout dynamically from message length and bus frequency
>> with a 10x safety margin over the theoretical wire time. Add a 300ms
>> floor to budget for I2C clock stretching, where a slave may hold SCL
>> low indefinitely during internal processing. This detects real hangs
> not only internal processing but it may go bad holding SCL low indefinitely.
>> 3x faster than the old 1s static timeout.
> Meaning, in such case/scenario, don't need to wait till fixes timeout.
> I guess, 3x faster is relative to the 1 sec, but for larger data and slower frequency it may not be 3x. Hence, correct it accordingly.
>>
>> For GPI multi-descriptor transfers, use the maximum message length across
>> all queued messages as the per-completion timeout.
>>
>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>> ---

[...]

>> +/* 300ms floor: budget for clock stretching; slave may hold SCL low indefinitely */
> Already explained in commit log, can remove second part.

This is very much non-obvious, please keep it 

Konrad
