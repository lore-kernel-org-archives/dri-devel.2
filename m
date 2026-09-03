Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4321CC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EF4E10F52B;
	Thu,  3 Sep 2026 11:16:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iub9610o";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gSqYny86";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A04D710F51A
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 11:16:53 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHJEM055337
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 11:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MUis2QM9xnepvuB3HlsDbxs/mCGH+BZAClAgP8cq7k8=; b=iub9610oCVRP5io1
 eD2EdPaOh9s0OF+FuCzdzEvyRO2nbcb1oSWsAKC5RKWzmlLBdjRs4/uAh4VGJTQQ
 5Wvyw2D4kANNKdxrJS1zABw+nm27BYHEbFqygHCHPqao+e0et34y3Aq/mWCkOoo8
 SSYmZR/gpB00tbs62XRqtonOiNHDwdTGvbidFhMBW1xBWzWQsVhkwK34FORm1T1k
 IAlVOHaF+TQHDtuJOUykvR0yPchfusJevDKUwUc+QOUB/lyItPxDvBURlus1Haiz
 OF+xBnIcy1OlDoNfx/axH86WNhUJ/Av5/QPJhsqKaUqVJZ0OdeJMvIuOHnyD2qjF
 C961Cw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdvmn1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 11:16:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9375d92d0caso38296385a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788434212; x=1789039012;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MUis2QM9xnepvuB3HlsDbxs/mCGH+BZAClAgP8cq7k8=;
 b=gSqYny86fBHwb5+bT+m+nS1jxkP6hhvce7pmr44jmdsP6varMP8Imt+yvcePX01ElO
 ikJaQ7m7Ost96gc3/1qupXDmGNreaXvxIn3T1iHYFDS51HUfT8TWvSupmM4TCIykipPV
 qDHOuYUsPoh5Vq10bnZa4bPlrYZb40m1RMaEPNBzfXodwrlqSzO1m1S+4Su0LfZGQ7mq
 s8zHRYJzKiL0Bu8jwDpcOxz5YQnh1fQHQmFF84+pm2gOZMRytttI+ZAqx0uzEhS8WSKs
 jcuUX1jzHEiJE6PbRGU3JozlIIel5H+W2PHO0FIYDAFyXlk9Y8kH7bHe0RIqfY77GKJG
 fkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788434212; x=1789039012;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MUis2QM9xnepvuB3HlsDbxs/mCGH+BZAClAgP8cq7k8=;
 b=mIf0Gva9t7FTWjaCeD60EfOV/fRurGyqxnZGd+56r1f6gJixsEyw2jHCnKKqFuektA
 zxdBYp/VcZTajKVc8No4PVLO5GOwu3K3xiz32l5HOor8qDL0nOt6OGXioIyL8z0ZBivk
 d8h23zJKT+kd2wo/5wS9icF/TMefehqvz8gKhcwBcYNBFWZvD0/315qWjXGVF3cSgoLF
 rBi3DG9n8PtJ4N7pVsXd8mDrVisxr84LBJ2hwrpCl3K2wCcE6guwatShW6kTgRa5iQKt
 dQodYmEUFqGOIpI/ygb6MElP8HpBuGY3/1UJpslxDux/a3FFfwQG0ojxkLujYbY79hHm
 vDNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5rFDUl2EOAFHjbDD7hqGn0T9vKEjIKNynLeFjNGOb9eml0ufOVHc2PRCaaaNhNq+MqkB4SQjCyUQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nK2nxwCt+Je5m5OU3CCSXDRge0gKZrmqext6kGUtqC7o5IlWU1
 NqdkyFS2uTZD9nnHkLD2UKWOGoVjeW4e/AETeZAkrtbc4Gd+Ufixgdfl2TaFLN7jpok5cKGbSjE
 czMSgBO5rgnrRU19kwFHfYXpgPt9Gd7Qok4pV2xdOTwVZYyDnaWO2X8zxQmu+q4wlHLE0PZQ=
X-Gm-Gg: AYBFou3VFvFFU2KeC2jL0c39SN7vWH/0/nmAFpvZ7MUndkZNo+WG6PtIpYG4YLy3DM1
 rR4r3jUNRKqXFgLBhG5PfLf5VPZVStPpMZAxRRSwmsVGYrDEuIkMPh/a8fyF/4sDvAr+MY+Httl
 9u2rhpjJcUCaorvotDVA5wbMtFpOv+94Gp/Gj8SU0R0/gYVF4dNDg8HMy6tj9USg5Hog9OQiNZl
 9UnyWjTbAkw6bVkMy9dRTxSBCr4h+QkoKVI9ZaLw9acMevQK6XMd71BMj5m26UwmsVY3Nqvp/k/
 urbDi3bR/RB8/fvarrw9AoPDkfXaY1CvdiuKPJC+NAOCIgull8GLBj/QrzocvS/31+r9ArbLdWS
 dQHcRnI5OB985+zWqB61pAw==
X-Received: by 2002:a05:620a:470e:b0:939:5924:e319 with SMTP id
 af79cd13be357-93960898d62mr801699485a.0.1788434211967; 
 Thu, 03 Sep 2026 04:16:51 -0700 (PDT)
X-Received: by 2002:a05:620a:470e:b0:939:5924:e319 with SMTP id
 af79cd13be357-93960898d62mr801696485a.0.1788434211575; 
 Thu, 03 Sep 2026 04:16:51 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a67f95f557sm2248372a12.31.2026.09.03.04.16.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 04:16:49 -0700 (PDT)
Message-ID: <084cc01d-f4ab-4ae5-8059-6ffdc3564b14@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 13:16:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/msm: unrecoverable a8xx hang-recovery loop on Glymur ("cx
 gdsc didn't collapse"); killing the offending client does not stop the loop
To: rob.clark@oss.qualcomm.com, Greg Ociepka <greg@ferrisoft.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
References: <20260820154428.1278@ferrisoft.com>
 <CACSVV003bOJo4OJGvwHAda3h+KoiVJnzOqjwAVfjNG=V-V+RAA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CACSVV003bOJo4OJGvwHAda3h+KoiVJnzOqjwAVfjNG=V-V+RAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a995724 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=zXLAmZJP3ypUEzgl:21 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=a8UEx8NLAAAA:8 a=B51BwOQrpoz89OxIyM0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=-yeuc7zBjbfZT8aiaP-D:22
X-Proofpoint-GUID: VmqlUJqFHlHL86pXSiXpYCnJGEVl_tY4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5OCBTYWx0ZWRfXxaDkCGyhzDTY
 eBCT1qU2wwIBhiU1zXWeORR0y2DXZZhkX5n6wz2967/9uScokv/cnDzk7nsEIzvhxKYhnnHnvnL
 Pbyawd+cRwofvDrkL3GcsuFSbHlZ1XnafbFJjb6Fub3ALu7B1uDwR7/tAi65Q28T/9DfFuoz34O
 e3fLoLkWavjMq2MehstsoUwW7fK1JBXokzPIueuhD3apIkihpRt0JyyU40itb93W4nzGIM3tcHt
 2pXUfV2gS8PXUDi/KHZtSZHwUfZFTg32b6g3lQ1+JAlKS2v3Y5+rWp2pfxHXhUDN1k7mZZnWTA0
 a62cJ9Kv9JaCtCunmVPdw2XcYjH6AILq+oKvVUik/WPkqccJLfdrmj/E2CaifQQspWjSKzhcLR/
 KKnCStOM+2sBNU12XW9FvpJuQF95XwbATBGFI7TAPwWMi4F4m1VGM+R1F1g4Jg+1lEtZJezwny4
 ScaPt131qvla9WOJDTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5OCBTYWx0ZWRfXw52rvnxgIMDq
 XpgyiBBN/udWhxwIHmlrBy+0jnRx+//mmV5es7SRe6ZxPSdZb1wA4Ub+ClBugHJGrDJpIGekurL
 ycsx3dx4FmajGZKAbgQ4mr2pAQ3IHao=
X-Proofpoint-ORIG-GUID: VmqlUJqFHlHL86pXSiXpYCnJGEVl_tY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030098
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

On 8/21/26 3:35 PM, Rob Clark wrote:
> On Thu, Aug 20, 2026 at 6:44 AM Greg Ociepka <greg@ferrisoft.com> wrote:
>>
>> Hi,
>>
>> On an ASUS Zenbook A16 (UX3607OA, Snapdragon X2 Elite Extreme "Glymur", Adreno GPU, chip id 0x44070041) we are hitting an unrecoverable GPU recovery loop that, once triggered, can only be cleared by a full reboot.

[...]

> Fwiw, the kernel I've been using: [1]..  but that doesn't have the a16
> dts. I need to move forward to something newer, hopefully I'll get to
> that today.  We'll see if I start seeing this issue.  Or maybe
> something x2e vs x2ee is different regarding pmic/supplies?
> 
> My device doesn't have the highest OPP (1.85ghz), which I think your
> device does.  We might be still missing some power related features
> that are (more?) needed at higher freq's, or maybe I have a more lucky
> piece of silicon?  Akhil would know more about this.  You might try
> removing the highest OPP in gpu_opp_table (in glymur.dtsi) to see if
> that improves stability?  (Repeat until it is stable if you have the
> same issues w/ 1.7ghz.)

Greg, have you tried this?

Konrad
