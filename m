Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319FECD4F5B
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 06:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7158310F4C2;
	Fri, 22 May 2026 06:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NSRNWJHm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nr51EoNH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6A5F10F4C2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:55:37 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M41MYU1815982
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=IyOLD6seNnEWHPteokJ1O9+x
 h+taSyfEG1bZP0Jxhcw=; b=NSRNWJHmaZND2lSgAI1Lbn7sZHFXwnosysh/H7OV
 lWwmUhnFprimWZINe3sTTlW3/4pfS0zcmDo5AL+tqRIuDlvZWxIp0ik0/ew94Pvv
 khLIPjGlomfh/bLHLpxVAaYUILKlwzsMUES+ORtcQTuX2KYfaz6MfdARIVTy24Nm
 MnVBUhzXYe+xAX59pKvA/sJCfCIa0/EzpJOymRplVmg3JtHRO1UxoF07EImCfgpR
 hUZbWuGFFZkXGJeZ8SiBfws2XNv5A1cFXnHJUd9uaSK0e200ABaX9odfBEoosFUD
 hGNb5tP6v2Rp80vtrjXdX2Yx7GJLnu+m1gpN8ONA6h7WGg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrm0hkb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:55:36 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c82c477290bso3749728a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 23:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779432935; x=1780037735;
 darn=lists.freedesktop.org; 
 h=in-reply-to:cc:from:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IyOLD6seNnEWHPteokJ1O9+xh+taSyfEG1bZP0Jxhcw=;
 b=Nr51EoNHiccCRGJyU025cgI1uhthntOb+APfOo3ElfLWwiqbUd9zfnK7D4OFOghnQJ
 9VUK+S3aiShE3yQGU2LIqLMRmSY5yBKSiHcMgTxTaj4ZwvORm434Sqr12iyDTBmdV9+6
 w/DpCGkqOFPZGv0j6FHbsNSI/5pTLYKrQhUBtRIktbTCaSKqGAfDu9nOY2l6T0s6kfDN
 JdND/oYtzNh0J4sUbeC/unHG8NK3nz6KcM7uJ6LQjU7DJ0LJs1izgvjU0/umyabw/eay
 5N5H++QpR2KyPx//bbNcsMOHu3Jg4ukrRWOJ2KlyMOugMGMzDZz9cwcsu/yxyjgpzbmt
 jzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779432935; x=1780037735;
 h=in-reply-to:cc:from:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IyOLD6seNnEWHPteokJ1O9+xh+taSyfEG1bZP0Jxhcw=;
 b=fm3y2JsFqjIcYrwcPvnLG3oaUP7CsZMLOMZdksZ3N8zZjWT5fBznewgOG5B6C1sgfV
 nnuTzieouV5zl2hLVK0POavmIZHGLzBwreQp+jeNpVTaAQQEHbP1agG4VCol2Ldlga8L
 nk4ASehf8v8W0iXQR0bCr924t0Q0V37wy5rtD+5AhzPMj0SLOxATPP9HVYAqK5eNpMvE
 /oid+rvGDrkGTUDwfKkAB/ahH6RWjscAqJvvImpR/UAn5uakQS6K3VeBGMFi+UCbXdc4
 P0vBvcuMgjUjQgHnzZ5vHUOFqSoK01wJ5YXOlavYtBVlDius8z5/E/+3OAqdj+HDh03X
 lvvA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wF6tl5WEzDR6KdhetG8GB0iy6zN1ZUrRh92u4dIMOijEC3vQruD6WjFhXKZe1XJo9jz+RorrARTs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoqaOYRcaAhDNUE4RJcbsf6djVNOzBvmMM1y/Jbf8QvkDEMc2f
 oLH/pE83S0QigS6Xv7hKo0DFgjQZb0k9o6ft6HH+oWM7zv2mKKAyugnd5Hilgk+uuzQp9Y8JyCD
 Y+YrVc2cxFrdl4oILxE3CDxR7WTvtSGh/d9pqF75ocG+T3k/geBEm6zn5zVBEgCNJ23/3ZUU=
X-Gm-Gg: Acq92OGR+bu1jUAeTZaXfBxFtJ4csNTfCnat0wYc2UjuE/bCUuMXnOgUuslws2+16mX
 4njLcIU56KjFqA9x/7lOOyCiguAxQUE6X1+45z6wNcZxstSPk1DRs1aIfJ7Q7JruYpxhej3kN9h
 zNxoTGi3diqO3qrtgvZmnU6IpWLjeNOBPZz0C5ziU4gQnBqtVUJBTkwlKaGoKtQteBV5z8n2fob
 joQVW25/jP4cOMNSJU69A+mUMnLAt0HaAqz5Wtu42p6E8IjfC26HhVSFeIFYVbPrVREmS8ykTv+
 kec+HWBP27MhUkVJRQzsWp3GjZxs0KGxD64ObKr1BPxg+FUNYUWO3MRj1H+NxHZdH4v5J7ahtVS
 cErZkGA9i8iQY5jmfIV1tNQxd/Or5oAUxYb0qlnrY3igCD1GqvVZbkigQzVg0Qh44MIgbdRMHbi
 DdXvcF7leHnq990+0w
X-Received: by 2002:a05:6a00:bc10:b0:82a:7dfd:9757 with SMTP id
 d2e1a72fcca58-8415f580dd7mr2541001b3a.4.1779432935258; 
 Thu, 21 May 2026 23:55:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:bc10:b0:82a:7dfd:9757 with SMTP id
 d2e1a72fcca58-8415f580dd7mr2540978b3a.4.1779432934759; 
 Thu, 21 May 2026 23:55:34 -0700 (PDT)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164aed7c9sm1122972b3a.13.2026.05.21.23.55.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 23:55:34 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------a0YosIPeLJGMVkMsK85fxUrV"
Message-ID: <37146a3a-b18f-40f1-b95b-0ac19bf6c07a@oss.qualcomm.com>
Date: Fri, 22 May 2026 14:55:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] misc: fastrpc: Remove buffer from list prior to
 unmap operation
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 amahesh@qti.qualcomm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 abelvesa@kernel.org, jorge.ramirez-ortiz@linaro.org
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-3-jianping.li@oss.qualcomm.com>
 <xnkycubizpoe4rmhc3jt36ulx2fb3tubjybu3djovafkqqttmc@o6vw2so5ctxr>
Content-Language: en-US
From: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
In-Reply-To: <xnkycubizpoe4rmhc3jt36ulx2fb3tubjybu3djovafkqqttmc@o6vw2so5ctxr>
X-Proofpoint-ORIG-GUID: zVFP2NMS-ZhtbIbdXwlvxSskmOg7uNUu
X-Authority-Analysis: v=2.4 cv=Zekt8MVA c=1 sm=1 tr=0 ts=6a0ffde8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=91DK_dnyKEatJSEmeisA:9 a=QEXdDO2ut3YA:10
 a=65MDuzgJ9_6jycvYPFoA:9 a=YS8qFNsjUaEB92ob:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA2NiBTYWx0ZWRfX4HnThFSBySJc
 gCBjFIyWT2Xvn7Q0Sm5U4msV9YjEObatHJfZgYwSKYMnpwWC7N816LtrdoBqUgIaKrvhU0Eh/gs
 Iso5ltJxSMpHlqNfSC82fj3jFYADoDNlCkXTOclpshVZXKBh1/qk6tvdNXGqQ5FIxS7wtKhZsln
 GUUFb0RDup2P6c27VrzLmWTUUl+/U4/aZR1Jxb/nRaOR/sUIquXkoMF6hAiV+fGEOsCWXHk8tqx
 kYWELwJih0WD+R0eM8ExDINk1lOAQWN8zni5Sd0WvfrFNiMTejpJ2LxRf3e4FY+4v+XfrATp37b
 MBe8Sq0YSI+UHImlesA56lhDO05ENBuP1UtiRufQZph/upIgsqAiqUfrSqLrz0hzlME6LjMwnly
 BF9WMRiGY0yLpfL79vN6wH/OEi7NNYtSUnRrR1mOGnElxDAHn1z33qB0byH8zkPErmJfsEfF2yv
 ywHzcX919LbN+PxNO/w==
X-Proofpoint-GUID: zVFP2NMS-ZhtbIbdXwlvxSskmOg7uNUu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220066
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

This is a multi-part message in MIME format.
--------------a0YosIPeLJGMVkMsK85fxUrV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/15/2026 9:36 PM, Dmitry Baryshkov wrote:
> On Fri, May 15, 2026 at 08:42:14PM +0800, Jianping Li wrote:
>> From: Ekansh Gupta<ekansh.gupta@oss.qualcomm.com>
>>
>> fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
>> getting removed from the list after it is unmapped from DSP. This can
>> create potential race conditions if any other thread removes the entry
>> from list while unmap operation is ongoing. Remove the entry before
> How can it remove the entry from the list?

Multiple threads sharing the same file descriptor may invoke unmap concurrently.

>
>> calling unmap operation.
>>
>> Fixes: 2419e55e532de ("misc: fastrpc: add mmap/unmap support")
>> Cc:stable@kernel.org
>> Co-developed-by: Ekansh Gupta<ekansh.gupta@oss.qualcomm.com>
>> Signed-off-by: Ekansh Gupta<ekansh.gupta@oss.qualcomm.com>
>> Signed-off-by: Jianping Li<jianping.li@oss.qualcomm.com>
>> ---
>>   drivers/misc/fastrpc.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 8b21f85cd9f4..3c7c3b410d7d 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -1863,9 +1863,6 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
>>   				      &args[0]);
>>   	if (!err) {
>>   		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
>> -		spin_lock(&fl->lock);
>> -		list_del(&buf->node);
>> -		spin_unlock(&fl->lock);
>>   		fastrpc_buf_free(buf);
>>   	} else {
>>   		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
>> @@ -1879,6 +1876,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>>   	struct fastrpc_buf *buf = NULL, *iter, *b;
>>   	struct fastrpc_req_munmap req;
>>   	struct device *dev = fl->sctx->dev;
>> +	int err;
>>   
>>   	if (copy_from_user(&req, argp, sizeof(req)))
>>   		return -EFAULT;
>> @@ -1886,6 +1884,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>>   	spin_lock(&fl->lock);
>>   	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
>>   		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
>> +			list_del(&iter->node);
>>   			buf = iter;
>>   			break;
>>   		}
>> @@ -1898,7 +1897,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>>   		return -EINVAL;
>>   	}
>>   
>> -	return fastrpc_req_munmap_impl(fl, buf);
>> +	err = fastrpc_req_munmap_impl(fl, buf);
>> +	if (err) {
>> +		spin_lock(&fl->lock);
>> +		list_add_tail(&buf->node, &fl->mmaps);
>> +		spin_unlock(&fl->lock);
>> +	}
> Is it expected that userspace tries to unmap it again? Or why is it
> being added to the list?

User process can call unmap and fastrpc library won't call the unmap again.
Fastrpc driver will free up this list during fastrpc user-free.

>
>> +
>> +	return err;
>>   }
>>   
>>   static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>> @@ -1989,14 +1995,17 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>>   
>>   	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
>>   		err = -EFAULT;
>> -		goto err_assign;
>> +		goto err_copy;
>>   	}
>>   
>>   	dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
>>   		buf->raddr, buf->size);
>>   
>>   	return 0;
>> -
>> +err_copy:
>> +	spin_lock(&fl->lock);
>> +	list_del(&buf->node);
>> +	spin_unlock(&fl->lock);
> This is a separate fix.

ACK.
I'll send it as a separate pacth.

>
>>   err_assign:
>>   	fastrpc_req_munmap_impl(fl, buf);
>>   
>> -- 
>> 2.43.0
>>
--------------a0YosIPeLJGMVkMsK85fxUrV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/15/2026 9:36 PM, Dmitry Baryshkov
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:xnkycubizpoe4rmhc3jt36ulx2fb3tubjybu3djovafkqqttmc@o6vw2so5ctxr">
      <pre wrap="" class="moz-quote-pre">On Fri, May 15, 2026 at 08:42:14PM +0800, Jianping Li wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">From: Ekansh Gupta <a class="moz-txt-link-rfc2396E" href="mailto:ekansh.gupta@oss.qualcomm.com">&lt;ekansh.gupta@oss.qualcomm.com&gt;</a>

fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
getting removed from the list after it is unmapped from DSP. This can
create potential race conditions if any other thread removes the entry
from list while unmap operation is ongoing. Remove the entry before
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
How can it remove the entry from the list?</pre>
    </blockquote>
    <pre wrap="" class="moz-quote-pre"><style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f</style>Multiple threads sharing the same file descriptor may invoke unmap concurrently.

</pre>
    <blockquote type="cite"
cite="mid:xnkycubizpoe4rmhc3jt36ulx2fb3tubjybu3djovafkqqttmc@o6vw2so5ctxr">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">calling unmap operation.

Fixes: 2419e55e532de ("misc: fastrpc: add mmap/unmap support")
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@kernel.org">stable@kernel.org</a>
Co-developed-by: Ekansh Gupta <a class="moz-txt-link-rfc2396E" href="mailto:ekansh.gupta@oss.qualcomm.com">&lt;ekansh.gupta@oss.qualcomm.com&gt;</a>
Signed-off-by: Ekansh Gupta <a class="moz-txt-link-rfc2396E" href="mailto:ekansh.gupta@oss.qualcomm.com">&lt;ekansh.gupta@oss.qualcomm.com&gt;</a>
Signed-off-by: Jianping Li <a class="moz-txt-link-rfc2396E" href="mailto:jianping.li@oss.qualcomm.com">&lt;jianping.li@oss.qualcomm.com&gt;</a>
---
 drivers/misc/fastrpc.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 8b21f85cd9f4..3c7c3b410d7d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1863,9 +1863,6 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 				      &amp;args[0]);
 	if (!err) {
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf-&gt;raddr);
-		spin_lock(&amp;fl-&gt;lock);
-		list_del(&amp;buf-&gt;node);
-		spin_unlock(&amp;fl-&gt;lock);
 		fastrpc_buf_free(buf);
 	} else {
 		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf-&gt;raddr);
@@ -1879,6 +1876,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
 	struct device *dev = fl-&gt;sctx-&gt;dev;
+	int err;
 
 	if (copy_from_user(&amp;req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1886,6 +1884,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	spin_lock(&amp;fl-&gt;lock);
 	list_for_each_entry_safe(iter, b, &amp;fl-&gt;mmaps, node) {
 		if ((iter-&gt;raddr == req.vaddrout) &amp;&amp; (iter-&gt;size == req.size)) {
+			list_del(&amp;iter-&gt;node);
 			buf = iter;
 			break;
 		}
@@ -1898,7 +1897,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 		return -EINVAL;
 	}
 
-	return fastrpc_req_munmap_impl(fl, buf);
+	err = fastrpc_req_munmap_impl(fl, buf);
+	if (err) {
+		spin_lock(&amp;fl-&gt;lock);
+		list_add_tail(&amp;buf-&gt;node, &amp;fl-&gt;mmaps);
+		spin_unlock(&amp;fl-&gt;lock);
+	}
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Is it expected that userspace tries to unmap it again? Or why is it
being added to the list?</pre>
    </blockquote>
    <pre wrap="" class="moz-quote-pre">User process can call unmap and fastrpc library won't call the unmap again.
Fastrpc driver will free up this list during fastrpc user-free.</pre>
    <blockquote type="cite"
cite="mid:xnkycubizpoe4rmhc3jt36ulx2fb3tubjybu3djovafkqqttmc@o6vw2so5ctxr">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+	return err;
 }
 
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
@@ -1989,14 +1995,17 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	if (copy_to_user((void __user *)argp, &amp;req, sizeof(req))) {
 		err = -EFAULT;
-		goto err_assign;
+		goto err_copy;
 	}
 
 	dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
 		buf-&gt;raddr, buf-&gt;size);
 
 	return 0;
-
+err_copy:
+	spin_lock(&amp;fl-&gt;lock);
+	list_del(&amp;buf-&gt;node);
+	spin_unlock(&amp;fl-&gt;lock);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This is a separate fix.</pre>
    </blockquote>
    <pre wrap="" class="moz-quote-pre">ACK.
I'll send it as a separate pacth.</pre>
    <blockquote type="cite"
cite="mid:xnkycubizpoe4rmhc3jt36ulx2fb3tubjybu3djovafkqqttmc@o6vw2so5ctxr">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> err_assign:
 	fastrpc_req_munmap_impl(fl, buf);
 
-- 
2.43.0

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------a0YosIPeLJGMVkMsK85fxUrV--
