Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B18CA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D80210EBAB;
	Mon, 12 Oct 2026 07:41:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 393D610EBAB
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:41:47 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C5PUPL1786870
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +Kup2LrkOjt/kWL0RBJ10nJ1bq30f7w7KzUsQkUZMTY=; b=MAnubNxLxV4EHkfe
 4xDz6THJMtqrIOoqXxFRBpqWphf0dCm685lrrwlVzeEyClyd0taBL8ue8G/PhyZm
 9cuE+aKpO+x06BLqODtjo0MWvfK9+bXoqaH3WQUtvZF65FIhx0WItilqfqNtci84
 7dQ8B3Cev+KOpzgpVgNElcbY85AymimtADxMQ44QFZMa3KIcZW512lMgauiFBwDH
 +u8SK8WNwfbBOI+1xo8Dl2PztwrKXokjoZZOJlpatl5hi1syF9wLXxvuPCxOog+m
 zxFpcPTMmXmGayTVEDqNKk0ZkyVZaLzYfJZZTOkP04MDkhPCUSD7rub3xWWMaq8i
 ESS3DA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1rk0s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:41:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5350d8a2368so3691491cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 00:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791790905; x=1792395705;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+Kup2LrkOjt/kWL0RBJ10nJ1bq30f7w7KzUsQkUZMTY=;
 b=h2A9vbMArE2RhrKxPLf8F8Lv3JC7PL368CdUXZCPcehBCyNktuR4CnSaPwcv0YyurJ
 9VQNMmtEXqO6w2Xv+MAmRN8Z5495Bc1i3QbovB0GjoYxrK/l9zOudi6dWv3zqBZdSEq2
 u4Eym7ZOdgsV/1HdQqNtudWx4LsFwG5Fln0HaUfjINPo5lISu/X2HhKzfXZ9fwhsbpAu
 CjeppjNPVv/NZo1fD5avsbyOkpDSe3YHf1qb5z82O065SepkYXBXtmTPCo3JJqsxul3R
 FoBxMJFDY9rqKXxAQHvgMeN875SEmSMAS4xxV2bESFiLVwIEJp14LFRlWOIIShvKspAP
 smcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791790905; x=1792395705;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+Kup2LrkOjt/kWL0RBJ10nJ1bq30f7w7KzUsQkUZMTY=;
 b=CbvnlLkUFtC2qj4rZm+wTxN/3nb4etiQS9h1jlLE/ak7ywLSgkUkIBVs4ml++uuAMW
 gOd1E5h7p6Ed6KSmvhfW2vhB/fRm2AD1fi1X5cKrOFlQVR0WH4TGkA1zZJm0h+I/tdRv
 oHYIN2TjnvncpO0mRx4PlJlhn+3Gi7MPOx97FQJ+amEuabr/ksBRumv7AOSjLWJGO4u1
 sm5PLD49rfxrt3hsVZAjNUCEtwd1vMAxGspgJ++uhVBNlZb6UtRg7wNKQeNUlp2nAG17
 H8B8I3ja1DtyZKVBcva4BG5eOCkWlOW/3SMzq8NMcGBO2EZjP1dyDq+PP9qNmFR9mjQz
 +g1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDxVlPz1UUO3IsUL/z2ceK6NDYYXNIacaBqquO3Cived04UA1ZAu79DzbZmINP2GHkh0ChPWSJwRQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJkVHyuZkzfdfqvZx8d+YsXlKFTVwaT2pFsqXoiDXX6ePg0ImzG
 cOgLvp6zr+7iLFJsIAZZ3Y0jcm/SjSNpEptoHzDOdGROi8F4S0zC5UkwpVqLqLlD5ZkIshquZkh
 m65x9q14XDbjV2c57tQCx5UlUeGZcDTSK2q5TomJA17gVmYAnG44HT+rapglHuXMWR1Niij0=
X-Gm-Gg: AYBFou1EZCcIJZKoT4YWj+rpQ0awSGkgZczq/s4ARr3reRbF2C1EJvi9ithmWx67kGk
 Ty4fz4EW3ZxEuKuLRVdo7YrULCDleVHOEZy3HDJroZqD/RqozgbPojfHBkWnIGuuEU6E2BK9Y+G
 wWFULNt7nN0K33JszgNGdQZArJLBoa6njYafHjdH9apXyp8pt218jf/k2J/A7JE+QS8oISZryts
 U79pdDmgochZ/l7KpPbwxt9ovospLLexJuzFIr2DfAdsKu/uBNGB8y22DtvqabE9kAd1UMMBfiM
 lxWGrAQUuShrLjdVym598hnJD0rkS4Q3pC/xf6Rasy+E3Ut3zkeEqlxCgN3YtlO91XelQeus4kd
 4AGoee6NH0tti9bL73AJEiA==
X-Received: by 2002:ac8:7f52:0:b0:535:1a83:1251 with SMTP id
 d75a77b69052e-5359fae166amr173329651cf.4.1791790905460; 
 Mon, 12 Oct 2026 00:41:45 -0700 (PDT)
X-Received: by 2002:ac8:7f52:0:b0:535:1a83:1251 with SMTP id
 d75a77b69052e-5359fae166amr173329331cf.4.1791790905023; 
 Mon, 12 Oct 2026 00:41:45 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a3ab4esm432818966b.29.2026.10.12.00.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 00:41:43 -0700 (PDT)
Message-ID: <45a2a77c-afcd-4dfc-89b0-4a17be1ff828@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 09:41:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: kaanapali-mtp: Enable USB headset
 and Type-C accessory mode
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
 <20261005-kaanapali_dp-v1-4-6faeac3a6d59@oss.qualcomm.com>
 <ytqzmngqzb2ear5ovqexrzcw63t7plac7hvsbh3ce32krt4mfd@e3yyzs6y5anq>
 <926167d5-e912-42b5-a040-be2bf220adbc@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <926167d5-e912-42b5-a040-be2bf220adbc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mVhgiV0fWrXtbU5oNqvJqUYeZEGga9yG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMCBTYWx0ZWRfXwx62Y190jD+r
 FzaJbGbgZv/ljQmp+IXSb/PWReeqaQzEiIvLkpLZ/DWqIwAaT38qGcDNfBu5Z69+nvTIZhDtzYx
 SWFCA5PcYz48WmUMkl3EwXFSFpJk7sU=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6acc8f3a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=IFwgObqpU61r2iwUQtYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: mVhgiV0fWrXtbU5oNqvJqUYeZEGga9yG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMCBTYWx0ZWRfX4jyWXjE9JfiV
 haJUsG3/oIZRLwDfrWpIpm2v0WJC6ORZwWZCFvRam0JGagm4+wkKI+UQ+CN7UGNey1wHVq6o1l9
 xjz6vqYhMUF+4Rl9Fyh78kl0lscl4eKLzmG+bmw/k/y5pQ6ItprWv+lWyzhEzU/zSRqbEWVSpLb
 w3SBEgHV88sBA4e+6Ip4milO1dTyqOKhyum1gPu/BplT39p4ly4q6mdlZ+5B14aOBRozaobaQ9D
 lxpVnQE6ZNmzCqXO7gm6OTnTF8I8tPyv66mJ8DWrC7mkjPl4g743osw6I/Hqr3hjTABAZyLzAVx
 +HgtxSKTyGOFWn7qWfyKTK0ehQS42sC1rBewT0CtI+2ZpILcl/jZxVUMDweZNHmrnRJ21N8xFm5
 0Rs8RZ5NmwfCLIDtN8p7cLUx+0HVFts/30tv8nAz6wi7PuoGS2fZ5wIcqb/+fii5gXz+tfc/r2O
 MG0nZNxlnIjhKTmNADA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120030
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

On 10/12/26 8:17 AM, Balaji Kalkonda wrote:
> 
> On 09-10-2026 02:04 pm, Dmitry Baryshkov wrote:
>> On Mon, Oct 05, 2026 at 12:54:29PM +0530, Balaji Kalkonda wrote:
>>> MTP does not have audio jack connected and relies on USB mux (WCD9395).
>>> Add necessary nodes for proper audio headset support along with USB
>>> Type-C accessory mode and orientation.
>>>
>>> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 51 ++++++++++++++++++++++++++++++
>>>  1 file changed, 51 insertions(+)
>>>
>>> @@ -916,6 +926,42 @@ &gpu_zap_shader {
>>>  	firmware-name = "qcom/kaanapali/gen80200_zap.mbn";
>>>  };
>>>  
>>> +&i2c3 {
>> No clock-frequency?
>>
>>> +	status = "okay";
>>> +
>>> +	wcd_usbss: typec-mux@e {
> 
> Hi Dmitry,
> 
> The default I2C bus frequency for i2c3 is 100 kHz as configured by the controller driver. That is sufficient for the WCD9395 USB Type‑C mux use case, so an explicit clock-frequency property is not needed here.

What if we change the driver to make the default 1 MHz tomorrow?

Konrad
