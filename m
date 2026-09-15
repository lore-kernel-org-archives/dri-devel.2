Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10C9C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1101910F474;
	Tue, 15 Sep 2026 12:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="e3GdsLBL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TxCQGyzZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA6E10F46E
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:06:07 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F9hOg93742087
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dv/lwoS3V7d29hXoBa6wYe4ULnStOXnmpv32FXjlKnU=; b=e3GdsLBLUVAuNn9c
 G5ogt74tr2F3FV6FavWt3YgI2isJhLyqHATDiyw/nK8oEDUcBhmTYUOEoEDSsMXW
 hjYQiP7gqxLN+BscNuILSYaHfBBG5le39KsiRSlVkYh0D8l5B5QuZ3t9dXKIVQte
 lBMEwH0W8OeV9qsOo5xRUBg0xbU/p6Qbc6VePgYAPhs+H6laYwwOsCdCgP/LNHac
 dOMqfFtVFCK7ZPtAlcCRNajizS1/RsuIfs4z+cT73BzdPks1a3SWXwHc6+C9ds/O
 PchiAYIpaZHDtZZzoaCysHI+6rUtPo7xuC4FQIB42U5gULwxv/Xv0vymAschkt3j
 2WZo7g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpyux1mmy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:06:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so10361057a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789473965; x=1790078765;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dv/lwoS3V7d29hXoBa6wYe4ULnStOXnmpv32FXjlKnU=;
 b=TxCQGyzZiXOij6VYPAYcddUeNSa1E0zkklKsaBmn3j2X9YmDjNa4IUS8sCIT+6prTx
 1Z05o94ph40k50up3mMgih8PzR9W7a/9T2x5wMxKd+8QyiODrfh/U5pS5uPMHDY2QmJa
 Mjo7e6iiu9m1/Y2BlwUPO5oQt5nceIsh5ZbsIVspJEbwTNfq8qT8bAzcDycDqtNQYmoa
 WNEiVtveX4QjJnZUr2hR7JLAMa73ECcZ+NE6jM+KIDGYb6YMuzMRzzuBkBU7PfgpOa2l
 Fq+vq1mXUUAXMJUkEKwxHZ3BKEU0dg43pJOJTX+pGj7gupHB+sctF/3BxkovP6ZoYaBe
 8tbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789473965; x=1790078765;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dv/lwoS3V7d29hXoBa6wYe4ULnStOXnmpv32FXjlKnU=;
 b=YDBWH5q/8ajfASbPBJJZ3ZWUXEg4iRO++O61PDGvqB3BdnMLvmoj5bBprZu3u+GvvH
 tCBgG+8EGihliPkjreU6poz6w7i0H1qqUMy7y5wfvR1ov5BWg2mLQJICNTtZcyxja1Ki
 ojP7sMNMRhHzzgpeUpX5UUtblCV1S1Frjg0PtMtqXwHWiGV4JcEDW4XyRNZtdXEMYmco
 deGVUjcBXN0mtplfblKtlGpD6ZgvV9IPj+wr8rtw4eeQ3wXFs6JONzM7LSyTFGLF7hlO
 /vjGBBuEmiRicKB8WoldSQmdocsXcX74une01mocLniJ2eplb2NSZ3inVs14fasu9ask
 UnIA==
X-Gm-Message-State: AFuF++mbd7o5ECbSQN2TSg4JQrVueDHuUz6w4k/s44egyVgfJKzr+1Kt
 6dRuUO1/gungN1AOpUQZKju3qu6CtIRupf4LPwye7CUBqUqGMoiutL7slBRANACE6rEiUcXtTuP
 jDhdv/tp20xqWLSnHPXsMg6PAeUdp+/dHjpcY5M3edRXCm+/DbLocCC6tqxo82lc4PT1NFu4=
X-Gm-Gg: AYBFou3iLRua36dQTT69AaDlcykWFD84nuezxGRdzc+sX7jLAYiucItFkIWvQH1TFvy
 ndUJ61i7x8hvpQ4/q+EtD0bsyvVEeWt3s9QsSsBXRk1LIsKfZ8VQG6HjghHx7Ee25hJkGS+Utel
 mVEhGRXo9cLipwX72+rzQOq3mO116Z/YV84iB9OvHG2Z+QAETQ+rlHZqjHDBkvG4/PBOaDKQ6oS
 pgbIx1gYRgRRXIt90QKlld2qQYa/w1WWUkxYoiY0wVKGdQSILew3ltckVp1gFRpYeuwTgdh2vnL
 W/NiCfT3/HmG4WPxmnXDTmggoX5wXV+AYLK8ictwz2+gcv7pyPyaguvD1tSNC/+yM7/RthyIrmJ
 BB2JgaWQfvVz+z+epwtzPX4XyL9s=
X-Received: by 2002:a17:90b:2711:b0:39e:f1:b2de with SMTP id
 98e67ed59e1d1-39e110988ddmr1151946a91.20.1789473965101; 
 Tue, 15 Sep 2026 05:06:05 -0700 (PDT)
X-Received: by 2002:a17:90b:2711:b0:39e:f1:b2de with SMTP id
 98e67ed59e1d1-39e110988ddmr1151902a91.20.1789473964758; 
 Tue, 15 Sep 2026 05:06:04 -0700 (PDT)
Received: from [10.204.78.62] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4c657156bsm6625938a12.21.2026.09.15.05.06.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 05:06:04 -0700 (PDT)
Message-ID: <725a4dd0-6882-4c83-ae68-109764d4daf0@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 17:36:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/atomic-helper: tear down HPD/polling in
 drm_atomic_helper_shutdown()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 sashiko-reviews@lists.linux.dev, freedreno@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
References: <20260730-dpshutdown-v2-1-441fc5543bed@oss.qualcomm.com>
 <20260730130104.3B4661F00A3A@smtp.kernel.org>
 <5n357w6ytzwbksbh2lnv47gbkioo3epbr55ddrw4ipn6vikexp@kbwvjmjuzntw>
Content-Language: en-US
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
In-Reply-To: <5n357w6ytzwbksbh2lnv47gbkioo3epbr55ddrw4ipn6vikexp@kbwvjmjuzntw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE3NSBTYWx0ZWRfX84FQg9aubwab
 ODhnx7G3dOh+DMBbKAE8Mq4SSDa/78v/nzjlEes7rbvHq1EPSZQ7kmez9QxZk+s5bXCwB+UAm3E
 x4YtUQSV6p0eEXtIzQv8WhSQ5/ySIeD9z600s3k7KgswqCpN+E4QJ++P5HhthF2r1F6L0amc0c1
 t57q3sM7MR5sGTz7ik1IFFPQ++/daqY52f3jRbmCEY5T8K51o+whAg4Ktu+Sz7ux8xs7dVeKnZE
 kfWVJZ3JL+orjVpSeVxqocIgCv++MH6hdOttXOGJ+73L7q5O95apyn2gUuUQ1ZLoYb0j5SYdWz5
 CMtzLArvTg3meHeDY+eBVGDDKdVhn252S5byAIHeFHu1vfquHgtl8DRsiYOoiIRIIKz2rDiJyxv
 trNjJNwdgC8gFGFeTwiJGy73MibGb4/dJgAXe/N990+1Z8aP1CQ+j0UpeTPGxhSmDPcKhLRURSO
 lz+Na8icRUt7mhQLVHA==
X-Proofpoint-ORIG-GUID: dLK9rDIlSoz-O-7b8XYSWmoleVwlZVtp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE3NSBTYWx0ZWRfX1wjla6+K335T
 7XQpXvSaqwV0O9aD2Y1zEWQL/DjlfLL9IqHyoAX9O2a30pDsUiEiA9Ow+U2ZOIvIt70h2WwdmoF
 CuS6LtZZ0GaDvZkBmPboGwapqOWD9WI=
X-Proofpoint-GUID: dLK9rDIlSoz-O-7b8XYSWmoleVwlZVtp
X-Authority-Analysis: v=2.4 cv=QYLzLcbv c=1 sm=1 tr=0 ts=6aa934ae cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=O6i0__nPXQNZU44mEi0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150175
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


On 9/14/2026 2:20 AM, Dmitry Baryshkov wrote:
> On Thu, Jul 30, 2026 at 01:01:03PM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>> - [High] drm_kms_helper_poll_fini() fails to synchronize with in-flight driver HPD threads and introduces a TOCTOU race with userspace probing, leaving the original late-modeset bug unfixed.
>> - [Medium] Calling drm_kms_helper_poll_fini() inside drm_atomic_helper_shutdown() introduces a regression causing a kernel warning stack trace (drm_WARN_ON) during driver unload.
>> --
> No response from Mahadevan.
  Sorry for the silence. I had been skipping the bot reports as noise,
  which was a mistake.  I will read and answer them from now on.

Thanks,
Mahadevan P
>
