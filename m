Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F2A606A320
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hAt8A3aT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Siadzi93
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABDC310E2D7;
	Wed, 21 Oct 2026 06:04:00 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4555C10E2D7
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:03:49 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5jNtI3573315
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9Cs8OoNct1gR9XcnBpixlZON
 0YnYw44lKTWwe1UxQQ8=; b=hAt8A3aTnvqm2ykzxu4iam4zpNfMDHTBRzfqOSUR
 pxMNlMnbeea+hxSlcY8OmFqnLkMwym0y5ztP3R0oiTGZKGbP0hfHoyS7Gf3J3wRM
 McftUvPcroVTXIePyPkQQjgZa4mbjoybiXFM08bL8Nk71wFdqyMtuIUipYf7UCvN
 R7EXLMDGG0Vi3mi78qoVGgPh39JeSSNwHBA8RvThnMBfujGovfVOhRuSQpWens+1
 FHvBC8Qn/olgnswlRt5x6mdX40tfdabSJJSwLq2u/eoLY2Qduux8SuQKrA7LEXVL
 A7a5jiJqgrTDV7eCtTzg/lWjleUNuc3fnqOobW1ujU6aaA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9ht8bd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:03:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ccb687f82eso2523795ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 23:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792562627; x=1793167427;
 darn=lists.freedesktop.org; 
 h=in-reply-to:from:cc:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9Cs8OoNct1gR9XcnBpixlZON0YnYw44lKTWwe1UxQQ8=;
 b=Siadzi933DaK4vv6nx+nVytY75cK4/I8XQGUGyChXHZ1T+PDUahRirClXv9495IPbq
 /5qceWXc/Dx3nWqJfuIurcLdXOWqosJ8c70gKSoxeOoxR7XsxfGvarHKb+UI1bvVATMk
 31uNEfoBYMfdWSyP5viyaJ2G4TswfazYzNZ+EjlxPTCS4+w3cTCGL9H3P+cKR1PrbU8f
 7OZ/g770ioJAjTmIfcKU0ZP7enrwUa02Sf/S+hjz5pOUDIhRUEfFzXLulh+sBuqIj1wm
 X3AGP+9RLUElMk5RjNK7vkVbPXNnAP6BFDxrXMtkvDJIK+2w0gKlx/PpdT8lqwqcx9HR
 DLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792562627; x=1793167427;
 h=in-reply-to:from:cc:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9Cs8OoNct1gR9XcnBpixlZON0YnYw44lKTWwe1UxQQ8=;
 b=qkEbhT12J7XraNLp32+NzwFQ5lg2ru6RHgCGI5VBFTs756SGW5v/RG0fgfwRlwTs9B
 VSMcbWyomA41oo3rvRUBgIG5dl+H6XCFb4vD1SbpqBEXA12RgN7/VBg/USBm4nTw2V/K
 zCo/1Z//fMoucrddxrx7vjV0638PNZ1BZQ4fB+l7U3QxRyFnc02mebdJoYh3mfqNotLd
 Erp/koriXjHrHAO7zppdK8qszCwnd/R6JfXLEbHq+GctUbUATQlCeThX5X/UKR74EcDy
 eTD0UoYYqt5BNJ38MVYzBvt+O4Ay4l3JTx1/LHcTT158j8qRagFYliL9ttyLk7IRODiV
 S9pg==
X-Forwarded-Encrypted: i=1;
 AKwUvByCH98UUZ9e5z5SsnwN0pO8GP8YRYyig4EEFgs7Vh+J41LBNaXMD7hihIgWvi74QtXYt/CoKXhZ+NM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI2/zMBHIU9xB5kZnQewfBjjVMUo34u/f+4nnuBHHP69InU+V5K
 SlJprkwIxDWUkrOPE61c8WfsD/zhQttnSLKrvJkh3XCSm7xQ7ujP7sUWtRyFZz2mz5DgnLrBC4N
 dHTKauRtDn7W2soghmPhJfDhzYpeV2ygG5g1VajSEyOb0m2m7lHfsuKBZqMk4SHmAM0px6qg=
X-Gm-Gg: AYBFou0tqCxZWUf5bUl+E5UC2zpsgGP1K4GmiUv7DjUTPF9oMhJ27AXDvqZKzgsceq2
 iDKIURNfI/srjIcFmduKLfW44+t3ZuA9clxnIerN1BQhtRdI1HgyTaZnOzLWt1xla6sUhSejdpM
 0/9RvI0mNysgnkva9m1K+j6b31Er/QttWpyWE9B83eFwhQG+aaUw7f6N0Ubqqkr2JuUpgS2/WVB
 qGsxELnHxw0XVcv6x3TUhKZAMszv53xrXTT7hkVdVAvMo5lRYoQcvm6K6p77ZkDTRs/epLJ4JlN
 Szv5zcLqraNvEA35xfKNao5b2WPZdKrCtRkd5DKCunQJS8ICx9PZOyxVU13+9idUTTI+HZC01Tm
 vIvUdMmk7NQDYXd8CaTEJ49LVHbCcScCrp0IPNzU68BCqdZdXi0AsdPsImq67gIkuEYPf9g==
X-Received: by 2002:a17:903:1ce:b0:2e6:913:57ed with SMTP id
 d9443c01a7336-2ea43d3a661mr8831495ad.14.1792562626652; 
 Tue, 20 Oct 2026 23:03:46 -0700 (PDT)
X-Received: by 2002:a17:903:1ce:b0:2e6:913:57ed with SMTP id
 d9443c01a7336-2ea43d3a661mr8831265ad.14.1792562626168; 
 Tue, 20 Oct 2026 23:03:46 -0700 (PDT)
Received: from [10.133.33.149] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b486b2csm6152495ad.61.2026.10.20.23.03.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 23:03:45 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------1s50UcRhJ5jg9PWWtratOcrq"
Message-ID: <dc7eb73f-60e1-4193-bd79-6733b4d12199@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 14:03:33 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] misc: fastrpc: initialise channel refcount before
 exposing the misc device
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
References: <20261007084447.922-1-jianping.li@oss.qualcomm.com>
 <20261007084447.922-2-jianping.li@oss.qualcomm.com>
 <2e1f73f2-5ac5-42f0-abfd-93d428528e40@oss.qualcomm.com>
Content-Language: en-US
Cc: arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>,
 thierry.escande@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com
From: Jianping Li <jianping.li@oss.qualcomm.com>
In-Reply-To: <2e1f73f2-5ac5-42f0-abfd-93d428528e40@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=YuKa1IYX c=1 sm=1 tr=0 ts=6ad855c3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pMb6-1PYoMgYJLWJ3ewA:9 a=QEXdDO2ut3YA:10
 a=rhkbLGPNnmkQcCxMrrAA:9 a=8vd1g_iN10SGa0Mb:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyMyBTYWx0ZWRfX5KOR/UPtcxgq
 uc+i1n5IEYlIyRax67j/q/Rd5ZhRHczWecF4QFTcGc8Kt4rxqNRU70W37fRJnE2ZdX5Xa1AJKgE
 PA6508ufKtZyPMHXoAL56DxKMzdXUVg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyMyBTYWx0ZWRfX3Dw3AWf7GZcj
 eAOn70GySKc4zv5EegQZDMNRHM33Z4qbFGrsPtfD1JAoueojgO0ATKovKtKdgyn+BHTZcefj5BL
 FhfpD8LBS7cpS6j8Bcd80s/yeNCxvvfA/m11/WAyqxMF2xfVhsubDiu0e/17gArrlEjVuXyveWL
 deajfo1AWP5tndp5aDKpF1jyjfhrCM72PlsAPO+LkE782NGmsGI9qUZ7W+DjmmB88aJsvWLho6n
 dFlL/015vZ3L4bLPyNWk06Crwflb4UpxgdSdtRS+Js4kYcxPl/nJ6QnZt+Pvk1pTTuI6ZplbZuw
 FUYwmFwrSGtXRCA7xwPEgcMRFaLKXTavvRiP9zL+SATtm48SsNhiYZqzcn+oHvyD25QBubX5TEl
 4SJS7y3/cPeJ06ANJISpWplPWUXY9h2gZeR7F1qYOaHf/m93RxK4jcvtsW1NH3v+zICQbHYEbYS
 QUOmK58viAfjuFxzbeQ==
X-Proofpoint-GUID: OfKhF44Yirk-hpFV07V51jD22o2jWdEU
X-Proofpoint-ORIG-GUID: OfKhF44Yirk-hpFV07V51jD22o2jWdEU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210023
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------1s50UcRhJ5jg9PWWtratOcrq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/19/2026 3:21 PM, Ekansh Gupta wrote:
> On 07-10-2026 14:14, Jianping Li wrote:
>> fastrpc_device_register() calls misc_register(), which immediately makes
>> /dev/fastrpc-<domain> visible to userspace. However, kref_init() on the
>> channel context refcount only runs after the whole domain switch()
>> completes, several statements later.
>>
>> Any process that opens the device in that window reaches
>> fastrpc_device_open() -> fastrpc_channel_ctx_get() -> kref_get() on a
>> refcount that has never been initialised and is still zero, which
>> refcount_t correctly reports as a use-after-free:
>>
>>    refcount_t: addition on 0; use-after-free.
>>    WARNING: CPU: 0 PID: 760 at lib/refcount.c:25 refcount_warn_saturate+0x120/0x144
>>    CPU: 0 UID: 0 PID: 760 Comm: adsprpcd
>>    Call trace:
>>      refcount_warn_saturate
>>      fastrpc_device_open [fastrpc]
>>      misc_open
>>      chrdev_open
>>      do_dentry_open
>>      vfs_open
>>      path_openat
>>      do_filp_open
>>      do_sys_openat2
>>      __arm64_sys_openat
>>
>> This is easy to hit after a subsystem restart, when the DSP daemon
>> reopens the device as soon as it observes the PD coming back up, racing
>> with fastrpc_rpmsg_probe() on the rebind path.
>>
>> Move kref_init() ahead of the device registration so the refcount is
>> always valid by the time the node is reachable from userspace.
>>
>> Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
>> Signed-off-by: Jianping Li<jianping.li@oss.qualcomm.com>
>> ---
>>   drivers/misc/fastrpc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index af18ff1992ee..05b2e7e4ad3b 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -2599,6 +2599,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   	data->poll_mode_supported = soc_data->poll_mode_supported ||
>>   		of_machine_get_match(fastrpc_poll_supported_machines);
>>   
>> +	kref_init(&data->refcount);
> Need to move all initialization before fastrpc_device_register(), this
> is already being handled by this patch[1].
>
> [1]
> https://lore.kernel.org/all/20261001-fastrpc-probe-fixes-v1-2-1376d93b8b3e@oss.qualcomm.com/>
>   	switch (domain_id) {

Thanks for pointing this out. I'll drop this patch in favor of the existing fix.

>>   	case ADSP_DOMAIN_ID:
>>   	case MDSP_DOMAIN_ID:
>> @@ -2626,7 +2627,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   		goto err_free_data;
>>   	}
>>   
>> -	kref_init(&data->refcount);
>>   	atomic_set(&data->ctx_seq, 0);
>>   
>>   	rdev->dma_mask = &data->dma_mask;
--------------1s50UcRhJ5jg9PWWtratOcrq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/19/2026 3:21 PM, Ekansh Gupta
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:2e1f73f2-5ac5-42f0-abfd-93d428528e40@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">On 07-10-2026 14:14, Jianping Li wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">fastrpc_device_register() calls misc_register(), which immediately makes
/dev/fastrpc-&lt;domain&gt; visible to userspace. However, kref_init() on the
channel context refcount only runs after the whole domain switch()
completes, several statements later.

Any process that opens the device in that window reaches
fastrpc_device_open() -&gt; fastrpc_channel_ctx_get() -&gt; kref_get() on a
refcount that has never been initialised and is still zero, which
refcount_t correctly reports as a use-after-free:

  refcount_t: addition on 0; use-after-free.
  WARNING: CPU: 0 PID: 760 at lib/refcount.c:25 refcount_warn_saturate+0x120/0x144
  CPU: 0 UID: 0 PID: 760 Comm: adsprpcd
  Call trace:
    refcount_warn_saturate
    fastrpc_device_open [fastrpc]
    misc_open
    chrdev_open
    do_dentry_open
    vfs_open
    path_openat
    do_filp_open
    do_sys_openat2
    __arm64_sys_openat

This is easy to hit after a subsystem restart, when the DSP daemon
reopens the device as soon as it observes the PD coming back up, racing
with fastrpc_rpmsg_probe() on the rebind path.

Move kref_init() ahead of the device registration so the refcount is
always valid by the time the node is reachable from userspace.

Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
Signed-off-by: Jianping Li <a class="moz-txt-link-rfc2396E" href="mailto:jianping.li@oss.qualcomm.com">&lt;jianping.li@oss.qualcomm.com&gt;</a>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index af18ff1992ee..05b2e7e4ad3b 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2599,6 +2599,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	data-&gt;poll_mode_supported = soc_data-&gt;poll_mode_supported ||
 		of_machine_get_match(fastrpc_poll_supported_machines);
 
+	kref_init(&amp;data-&gt;refcount);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">Need to move all initialization before fastrpc_device_register(), this
is already being handled by this patch[1].

[1]
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20261001-fastrpc-probe-fixes-v1-2-1376d93b8b3e@oss.qualcomm.com/">https://lore.kernel.org/all/20261001-fastrpc-probe-fixes-v1-2-1376d93b8b3e@oss.qualcomm.com/</a>&gt;
 	switch (domain_id) {</pre>
    </blockquote>
    <pre wrap="" class="moz-quote-pre">Thanks for pointing this out. I'll drop this patch in favor of the existing fix.</pre>
    <p>
      <style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5; </style></p>
    <blockquote type="cite"
      cite="mid:2e1f73f2-5ac5-42f0-abfd-93d428528e40@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 	case ADSP_DOMAIN_ID:
 	case MDSP_DOMAIN_ID:
@@ -2626,7 +2627,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		goto err_free_data;
 	}
 
-	kref_init(&amp;data-&gt;refcount);
 	atomic_set(&amp;data-&gt;ctx_seq, 0);
 
 	rdev-&gt;dma_mask = &amp;data-&gt;dma_mask;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------1s50UcRhJ5jg9PWWtratOcrq--
