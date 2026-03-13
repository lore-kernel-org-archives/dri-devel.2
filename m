Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEEB106FD98
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 07:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2046910E062;
	Fri, 13 Mar 2026 07:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kYOta4Hp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KK0Mp9hK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C63D10E062
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 07:18:13 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D5temb3342525
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 07:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i2IlKIi4brx2n2555N+kXUhgIRruRM2KVO7+XTSNjAw=; b=kYOta4Hp6PVm9IEo
 z0kzYQ7SouURAyJ6rUTTvPIoClsZXCgEpgm9eIegOOHN5QFlkHFjyubBt7hd7hyE
 cbOMlzo76yJn1yxqMtA+ZqwPGfS3bCV34TogNZSJ5/VCPWu5j49ux1+sRj+B651n
 QGMQiDz/iJd05KRzSFJVg/BFBYj4+WjCDwsdxWkF38g0A75m5ktyIstd2V8SbjET
 zdzuNBkA1Zws7sfX9UWbOnpwy2H1OrCtQuJG/DgGhjZ0x0G+e++0ROoTnPyA5xE8
 L1G9gTSRqrfL0RXA+uVzBkq+8GWOL5dpt1EhWOIeq/L6JCiZfHVex8W+W5phkdJb
 rpJ2HA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cus9w3ng7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 07:16:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ae3f446ccfso19494955ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 00:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773386177; x=1773990977;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i2IlKIi4brx2n2555N+kXUhgIRruRM2KVO7+XTSNjAw=;
 b=KK0Mp9hKbgDY7wulBFnPSmr2DbdThbm+YlEPLJSeembPys+kq8U6ExklM9h9VSoghO
 fyCpHDuaoP3es6N8WCWt6/s8JJGEKj0JaDp70A8dyX79oWS9KR0RNeaCsnHHj5B6er/M
 43dj4CyTUfy2ViZ86dn9HVXlVjrA7elXljJwIs345+VlLtLJLuGdpJLar9ryCjg60k/S
 ZNSsonk00Qd2s+jWsB62q6mxx3NCNGI7JoE+8/WU6SdlrNvScWC2bYXXMXDbKmKybM9w
 3Kyab8gFgQM6gBCPNg6c1P6ePVeQkDppp/UjBsy4GhKpw8eafqSPL5/FEog2RK1JGB+1
 QPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773386177; x=1773990977;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i2IlKIi4brx2n2555N+kXUhgIRruRM2KVO7+XTSNjAw=;
 b=SW9mQjEGeHG6jKE/KVbS2GWCDeVkqiQ8GAORyJOm+i3LdvnBmCOuomNPz+CrJgHouf
 pkgWUjgecr4AYoRqTSQJcTDB4bODkcBF9n769aYmjMIeF4GCQvZwX5/nbXd0d0xKmzwg
 HnSyxaBPdFkxN3BSnmjqKBEnHTrlmatFlxgrDWK8Tav8x87iEC+0h4NLvnsX2t6gTQ4C
 8WV8Xkoa6oUHnknzW6frdIY6gKp6mKryAl2Xt0LFDyZnS+JZ8Wtw20eL5y9+6TICDG7w
 GLICIBYk+9JqsI1/+Wz8xoxLt+JI6+bs06CwX61yFQym6Z0LRhLz+aS1la+5qs3ToTWX
 5Zxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqP28zI9zCIGXuXeJCXGgDKNGRk7mcCGUak3SYxXDT5rB2wnSaR0jxQzKs3vpAshANN1gQ5Nfq+1k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0KizukJr/Bam9wvidmd7AU4Ov8KAafPT9mlZ3DTvLMU/wqQkK
 0K+gTI38Getf2h/+ZzIzousGlKnpgOMKz/THdU9xsYWH73BuwlRU/FpyyKexoq0B1vpXevAhaOb
 mmxAIql1lD5Zr8QXrJpusVSe1XJkEFMC0UcOfdUGL9SCawBmt6H0VzDjnbrgVb2bCryS8IDI=
X-Gm-Gg: ATEYQzypoQk9DwvR+W2YJsWPeL9sadrIbE00rx+Ctql5EAX/mnH7nb0OADny8R4VorO
 kJM/6Q2sdzzahd8JNWPnz8GIHheRp87p01XkNaoK8WP9AuAfAh1tjDz+1X4zMk2Nz5ufUdNYLWQ
 YfTz08AEHpXg+jtgG3SgtDtCkuB22gJe1ddskqNc3dFFSRTA0iBdBNlfjDrrbnqCNx+ZUdymJ2i
 yfBeOcK7otkMbv4kQUY4F/Wi/QMa0bAmgl4fXTCKMfC2CX6kXE+8Io3lWXS5ZbbcevJ/fQHZAHW
 xFUSE2wT+4tabS7AE5nCQ99ZhQQX1KpxeyX2Fn9cwi39eYF2qjS0eppcMK3pEUvSo+J5mgsR/Vl
 M5YLrmB+4BcZn8ZrhbqjLuRUIc+0s7BcI8Zgz4mDNij7JCewCViFZug==
X-Received: by 2002:a17:903:390d:b0:2ae:3cf0:3aa1 with SMTP id
 d9443c01a7336-2aecaa3bfe2mr25528735ad.37.1773386176727; 
 Fri, 13 Mar 2026 00:16:16 -0700 (PDT)
X-Received: by 2002:a17:903:390d:b0:2ae:3cf0:3aa1 with SMTP id
 d9443c01a7336-2aecaa3bfe2mr25528405ad.37.1773386176268; 
 Fri, 13 Mar 2026 00:16:16 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece62c733sm16610105ad.35.2026.03.13.00.16.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 00:16:15 -0700 (PDT)
Message-ID: <a17e4c07-1f00-4b0d-90e3-2eeb1e71a248@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 12:46:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: mhi_net: Implement runtime PM support
To: Bjorn Andersson <andersson@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 netdev@vger.kernel.org, mayank.rana@oss.qualcomm.com,
 quic_vbadigan@quicinc.com, vivek.pernamitta@oss.qualcomm.com
References: <20251201-mhi_runtimepm-v1-0-fab94399ca75@oss.qualcomm.com>
 <20251201-mhi_runtimepm-v1-3-fab94399ca75@oss.qualcomm.com>
 <nj4ovttt4i7hsqfdv5zhdotxrx3upxfq4ozuligwuheubnsmkd@e6bwzgkn55kl>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <nj4ovttt4i7hsqfdv5zhdotxrx3upxfq4ozuligwuheubnsmkd@e6bwzgkn55kl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sZ88XEBXdtos98MOy55EFDLDX6x3tb2m
X-Authority-Analysis: v=2.4 cv=IIIPywvG c=1 sm=1 tr=0 ts=69b3b9c1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=8pif782wAAAA:8 a=EUspDBNiAAAA:8 a=BRVcir-zca08BhkZB6AA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1NyBTYWx0ZWRfX8gJ7PenXoUfO
 /eDVGFDBs2RywKfhqvgnmd3ndxmhF4lBjZAbyZFOQ0jBrqWZDulDPztB/Q1dECaNZ7jj/OypAU9
 zVT2Ib+Bs1jpjHxgaqwIMXtISX0ZQZaVxzkWyXATFz9IYdrAFMbyUquik+Ne8/qyMzj5qsZnvoW
 LrpHnRyKXZOYZHR9KkjMeiq0Wv+haxwVfhlnT5V4xgQ7SLYITAF9nh8m/q0JZ4kSjRXrQi0xu/H
 9cJK0wTa9UpdMtBy50LvLZVbzCkLAacogOnuHH0tZBzlYriQLmydkHdFYBkqCCAbdGEBsFjxuWO
 KCc2goPiJsGsH22kgOTbnrJNqiXApiDEbX1AcusJmkcI9iisXocF80BQ3TkfbHHrlRCVVS81/wg
 NzVRnJdaQMrA0N2skdCxT8UH/vjAbG8MLl5lm6WUI01VmkXzg9z+JcoDTRbPQiJKYkkUlwxTU7J
 jizmU4U8ZOoktGXPZqA==
X-Proofpoint-ORIG-GUID: sZ88XEBXdtos98MOy55EFDLDX6x3tb2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130057
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



On 12/3/2025 3:07 AM, Bjorn Andersson wrote:
> On Mon, Dec 01, 2025 at 06:13:19PM +0530, Krishna Chaitanya Chundru wrote:
>> Add runtime power management support to the mhi_net driver to align with
>> the updated MHI framework, which expects runtime PM to be enabled by client
>> drivers. This ensures the controller remains active during data transfers
>> and can autosuspend when idle.
> This last sentence hints at there being an actual problem with the
> current code. Perhaps we do this because it's the right thing to do,
> perhaps we're making this change because devices are crashing and
> burning?
we are doing because its right thing to do, with current code we are not 
seeing
any issues.
> Start your commit message with making the reason for your change clear.
>
> Ask yourself https://en.wikipedia.org/wiki/Five_whys when you come up
> with your problem description.
ack.
>> The driver now uses pm_runtime_get() and pm_runtime_put() around
>> transmit, receive, and buffer refill operations. Runtime PM is initialized
>> during probe with autosuspend enabled and a 100ms delay. The device is
>> marked with pm_runtime_no_callbacks() to notify PM framework that there
>> are no callbacks for this driver.
> This looks like an AI prompt, does it add value to the commit message?
>
> It can mostly be summarized as "Implement pm_runtime in the driver". The
> only part that's not obvious is the 100ms autosuspend delay, but you
> skipped explaining why you did choose this number.
100ms taken from pci port bus driver reference, I will add the reason 
for 100ms
in next patch.
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/net/mhi_net.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
>> index ae169929a9d8e449b5a427993abf68e8d032fae2..c5c697f29e69e9bc874b6cfff4699de12a4af114 100644
>> --- a/drivers/net/mhi_net.c
>> +++ b/drivers/net/mhi_net.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/module.h>
>>   #include <linux/netdevice.h>
>> +#include <linux/pm_runtime.h>
>>   #include <linux/skbuff.h>
>>   #include <linux/u64_stats_sync.h>
>>   
>> @@ -76,6 +77,7 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   	struct mhi_device *mdev = mhi_netdev->mdev;
>>   	int err;
>>   
>> +	pm_runtime_get(&mdev->dev);
> What happened to your error handling?
ack I will add error handling.

- Krishna Chaitanya.
>
> Regards,
> Bjorn
>
>>   	err = mhi_queue_skb(mdev, DMA_TO_DEVICE, skb, skb->len, MHI_EOT);
>>   	if (unlikely(err)) {
>>   		net_err_ratelimited("%s: Failed to queue TX buf (%d)\n",
>> @@ -94,6 +96,7 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
>>   	u64_stats_inc(&mhi_netdev->stats.tx_dropped);
>>   	u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
>>   
>> +	pm_runtime_put_autosuspend(&mdev->dev);
>>   	return NETDEV_TX_OK;
>>   }
>>   
>> @@ -261,6 +264,7 @@ static void mhi_net_ul_callback(struct mhi_device *mhi_dev,
>>   	}
>>   	u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
>>   
>> +	pm_runtime_put_autosuspend(&mdev->dev);
>>   	if (netif_queue_stopped(ndev) && !mhi_queue_is_full(mdev, DMA_TO_DEVICE))
>>   		netif_wake_queue(ndev);
>>   }
>> @@ -277,6 +281,7 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
>>   
>>   	size = mhi_netdev->mru ? mhi_netdev->mru : READ_ONCE(ndev->mtu);
>>   
>> +	pm_runtime_get_sync(&mdev->dev);
>>   	while (!mhi_queue_is_full(mdev, DMA_FROM_DEVICE)) {
>>   		skb = netdev_alloc_skb(ndev, size);
>>   		if (unlikely(!skb))
>> @@ -296,6 +301,7 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
>>   		cond_resched();
>>   	}
>>   
>> +	pm_runtime_put_autosuspend(&mdev->dev);
>>   	/* If we're still starved of rx buffers, reschedule later */
>>   	if (mhi_get_free_desc_count(mdev, DMA_FROM_DEVICE) == mhi_netdev->rx_queue_sz)
>>   		schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
>> @@ -362,12 +368,19 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
>>   
>>   	SET_NETDEV_DEV(ndev, &mhi_dev->dev);
>>   
>> +	pm_runtime_no_callbacks(&mhi_dev->dev);
>> +	devm_pm_runtime_set_active_enabled(&mhi_dev->dev);
>> +	pm_runtime_set_autosuspend_delay(&mhi_dev->dev, 100);
>> +	pm_runtime_use_autosuspend(&mhi_dev->dev);
>> +	pm_runtime_get(&mhi_dev->dev);
>>   	err = mhi_net_newlink(mhi_dev, ndev);
>>   	if (err) {
>>   		free_netdev(ndev);
>> +		pm_runtime_put_autosuspend(&mhi_dev->dev);
>>   		return err;
>>   	}
>>   
>> +	pm_runtime_put_autosuspend(&mhi_dev->dev);
>>   	return 0;
>>   }
>>   
>>
>> -- 
>> 2.34.1
>>
>>

