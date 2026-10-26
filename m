Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150CA606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TpZsGSX6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RVV1pcQ0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F11110EDBB;
	Mon, 26 Oct 2026 10:37:53 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE57E10EDBB
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:37:41 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4aVtb2222637
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Gqjg8xNmhBbt2RfYvkv54a120ybeK1H1UlJE53Iy9OE=; b=TpZsGSX6x4fCHbKw
 U8ef/568RxKDz0hovaxFvn9IInCc6pKY8/Sn3J7Cbt6yKqZr5KGpuZkWs9oe6j7k
 brO5+mOteKXKVH5HZzNaziob0mdnSna+I/c9Up4HcMbd6mprqlDkbSmUutdRWsP+
 eoa+c5k8kh9tObqrRBGOrjRsw4WJGbLPV4MsPhrjHrhfaDss//ip8gDbQn7ZD72+
 l+QQlPfcVAdnMvjQgAfLhDg7A6URh6DAhD0A+pYAdoljS0JxoEy4D2Wu7xtHHsL+
 cRCQRxsvNGOHaC8b82Ix7/gO/UBHgrG7XrIzmwzmfJPdUoxP39bSBmvh/XnrtdJ4
 32Agig==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd9qj0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:37:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53657d237ddso3590821cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 03:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793011060; x=1793615860;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Gqjg8xNmhBbt2RfYvkv54a120ybeK1H1UlJE53Iy9OE=;
 b=RVV1pcQ00uX5UpR/oEYA7z+R0n2i5oxlwVd6kEZS3RJ8VThBI5yojYTh8/KT6iqfZZ
 8KpZrOZSS+wltlWv2K3HflAwk5LZqd0r4J2epOuQTc3svUf3dL6RoErBXBTGMqqFkEzO
 /WpQJBrWOsIha0APji8QaeWh5bmUHYgdVT2rueu219AY9Jzepyf08Gh7HCQgMDeP+r3b
 feXP0cdEsvoIMncNF3zMhFhsoIifWE5ijtFRCkW918M9BHVzmXHnMHOQZn726upS8KHQ
 aqNpBp6B6ifq7aqsYTG0vXwwznS6spgk4NBGAowYkuxHGc3D+frJ3xV3XSUl6RJpKuz3
 Ddlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793011060; x=1793615860;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gqjg8xNmhBbt2RfYvkv54a120ybeK1H1UlJE53Iy9OE=;
 b=qv/L/cfhRpIQckRIKou94cOVXdXzqIGJl+XxEY5G+TjLlkrbu9T+FfbyCdDsizWDHa
 VfMTTwvGshK6x/8qQD3YageAIIHoLr1S5KodLJdMp/l4lCvrl5oCp3LtPN/dzBKdh2su
 bc3vRHoutbZzmmS9Wsfe8U3GWAYjqFSjfF2aPMZJsiLGSI/tfSQhTQbZoeXcJsJqoyPK
 3zTT4/p3MsriMASdtgDG5A9fOZJHecfpyXuJclkbQZAsRG45JBWcBNWdMq/SYHIgqqTT
 +zlDJ0+CesaQ8a6StlG3Bc0TJnMItxSQdRWe5uuA5d5vFofdWPK083cc7l9G0Q1Pgs10
 fidA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzf6y8ilKBOnf6toPXvpyrF45ifXv3JcNZIEyOkzB0fV+oirvwodomEmExFGK9G6J3AixG4eeAbu7I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLjN3LwrdD0k8rfDSUotAIaWNftUBWbgyTQoMnl+g9XE7JGp8lo
 lPoIhIO8BTllA/G+0uuHifIr8aoo8gG8ZS3olTvnygn0NcdqEc82QwD2HA3tXh5X9BdrX15kZgp
 9yE2985tUYuTPqA9MDsEAwH9BO1dWB2rsvsaS6ZmZ8q2OaLNMR68Td9/o1421vqxEETI8qmQ=
X-Gm-Gg: AYBFou1/jrZA1cxacrtXmojqKquwhuWCzPwl8FuvARi+ORYe56NwoXvArebFGjL0D45
 TzWJPRfxE5E8OH5lTJpe43hCXboMkwMfBpJ7czTA3lz2OiBvk61D/Ae7iD1++ve/kdDCiYpduWu
 4FalJB9cSuu7+LYb6BfWtNr+l9QblPVOKQ4VnixasysDvO0K0rHFtR+1faKddHGwAolP2/zmibE
 UhBU/G6Ukn6039hd1jegbcL3fCjXpKszm5S+IKlilvDLrUkOj+/277iU3B3dVt/vPK5ZFViU+TH
 C156Z/44Go3z/574DR072Yzsonj4tXu+/Fuo4qnN1bPcuFYdegpLiQBNicQ5/bkATZ4UTblO7RB
 U18b59i207A9kxgSzuIT8Xg==
X-Received: by 2002:a05:620a:4e84:b0:93a:ec4:e5f2 with SMTP id
 af79cd13be357-940ef9710femr1130935585a.6.1793011060059; 
 Mon, 26 Oct 2026 03:37:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4e84:b0:93a:ec4:e5f2 with SMTP id
 af79cd13be357-940ef9710femr1130929785a.6.1793011059540; 
 Mon, 26 Oct 2026 03:37:39 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4459924bdsm3389733a12.37.2026.10.26.03.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 03:37:38 -0700 (PDT)
Message-ID: <7b95f254-ccb0-4ce3-9b35-c605cacdf74f@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:37:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
 <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
 <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
 <t5gu6ciwmxdb2jghc44gtixdsbedkgy4yzke5sgawjrr2h362u@ahvhh3yfe6lx>
 <wtun2cfukyzxlsfiz2izsejd33k4jpapwqa3uqih5drcsrkff5@e6llkke5dayw>
 <1f6db59c-b7a9-41a1-8022-6713365fa09e@gmail.com>
 <fcb86c33-1893-47bb-80eb-20acd65f3805@oss.qualcomm.com>
 <o2zmplbtmoueumw3iqejfsdmucp5f66woa5hmw3vodbe66reab@syn2ashugzyg>
 <7d35f41a-c72b-4743-b8a4-0ba715be6756@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7d35f41a-c72b-4743-b8a4-0ba715be6756@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XxcfGXnBLVa5-iaMiSGpDLx4PeVQGbEZ
X-Proofpoint-GUID: XxcfGXnBLVa5-iaMiSGpDLx4PeVQGbEZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MiBTYWx0ZWRfXz/tP99oBu1HI
 K6ynCIM/yo6hHt/+XlBECx2kxWyv5mPgdNkg9MlFeDXWsJt+lW/ESELaI9L8RWcI7Cuei2n8EPW
 VsHQl83KLtuYpXFluNRkwEZk8yEK/8G+3Spc1QxS9KAfZWOsQ4BAqnOmFINPL9YCDUObqHgc94o
 irswE4kfI2peNxV/Kfpycu3DQkNXC0jIBD0TOJxWN+dyNXRR1bslLehNFDpUw0YZrFw3SidO5g2
 UqPRDCdnqJbuzN2r5aMLcfyfx5SZz4Iz1S0wXbkacX+yxBEW4CMs2FgiADKQSTWAu5/n099ar+1
 DGVsJg5Xaulm7tEpMzlJZ2sX7eYi19Hnjq3UYgXDMkh3zbdeWipjY+4qQKmbGXQlmf6akkQX8h3
 cnLsSBmDUY+1+NQtf4tET17/zg975ZVefSTKn6mxR+jMb6Dd2WDkeHa8ad7cPYQacLkAClssRc7
 CyIVrnmINK7nZq7O9vg==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf2d74 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=vYu95guM48VmnKZvmccA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MiBTYWx0ZWRfX+3QHeCGtc6bV
 GUo0/fjDpYFFq/vGmhiJxfeNaEfIUio5YVDnyu8HdInUVtYazUzqgJ7n07n8L7DcSPUMZwpi8s4
 /h00BHLdhVDoEzLSb4OSUMttnoOT7Oc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260042
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 4:57 PM, Anna Maniscalco wrote:
> On 10/24/26 1:36 AM, Dmitry Baryshkov wrote:
>> On Fri, Oct 23, 2026 at 03:16:27AM +0530, Akhil P Oommen wrote:

[...]

>>>> One thing sashiko is pointing out is that new dt should work with hold kernel so, in general moving sid1 from there would break it since old kernels don't know how to handle them separately.
>> The rule is the opposite: new kernels must continue to work with the old
>> DTs. If the new DT breaks with the older kernel, just specify it in the
>> cover letter so that Bjorn doesn't merge DT changes before the driver
>> changes find the way into his tree.
> Ah ok thanks for clarifying that.
>>
>>> + Bjorn/Konrad
>>>
>>> Not sure how strict is the requirement for compatibility with older kernel version. An
>>> option in your case could be just do an override in the board dts file of the
>>> Steam Frame.
>> Anyway, would it be a problem? Does GPU normally use SID 1? Or is it
>> only used by the LPAC?
> It is a problem because, even if nothing touches the LPAC ring, it's firmware
> will still initialize and that will cause page faults if sid1 isn't setup.

We're slowly coming to terms with the fact that all of our multimedia
iommu setup was terribly wrong all the time. Venus/Iris recently had
a flurry of breaking changes. We have to follow suit.

Konrad
