Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A112CC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6463210E2A8;
	Tue, 13 Oct 2026 18:56:34 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2036410EF7A
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:56:23 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DE3w5a1492053
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dVW2EdRxla6E0QM69Q3E/be+4rJf2zGLJLbIi+wd6SA=; b=LyfNmFNMtY8X499b
 2LyB1tCvlZ8nclC5N7sgYScrqzUIsLNu3+SFUC3pZsurc51YQrZiSVpHkxj5EYFN
 qkuIxvjobU9LZtXEkmWEGvI1mlaDFL1L4iXudWdwHiwSj36z3EVTGzE0wrRxtEam
 fa8mdjUavJv/yl7SUgduojWx8kWcWVPMkQRjJVhLmKY5H3MEnZzWVTD9OXWY6TLu
 bcCA+9WieeZwOIeZtStqWQPK4EO2cIiDjOBlb+03D7M2zb51JEHEv1t146UDRf9y
 gw95ob1mJyLZdufBgK/hHD0LivQu0YJ71JovqpY9U2cY0uWjBIvkka87OFaGJG55
 Fuw8fA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9daquskm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:56:22 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so8943234eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791917782; x=1792522582;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dVW2EdRxla6E0QM69Q3E/be+4rJf2zGLJLbIi+wd6SA=;
 b=cTCYHJ2RR8L4RvwoctkQeqaQf5bTgLMSLE4J8qx/9WRWqc07HuyLwqWGcNMppSObnj
 FUvnVDTu0ypOolz0pHvG/VAUPh4neYd1SdgpMUS0kgLiqH3jAWUEvzt+6AkQk1q1GEpN
 ZYf7xqCfwuZDCcZC6ULyPJjIIGax9t831Odk1xaxoimG2XXsD91PqRZ8e2uGgHA3RkQp
 X5JdLvnaFnsB0FLxULeliCEHmNa1Tm5y1r184hgFCjBXkI2/i2xP3wGDBd4w9xQDCqUu
 EDOHcikLobQyH3UrkxxnibKWHAy8kUJf9jmN5RgprV0Z9h35M72VH/CcS2BPEkFrrVkM
 a96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791917782; x=1792522582;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dVW2EdRxla6E0QM69Q3E/be+4rJf2zGLJLbIi+wd6SA=;
 b=Q0aQK/hPZdV3Gj/oE6sAeDS1HBcJcEV641zaQ70jp5pPv73xn7DSlUEnI92ya+lTNd
 Vu1WEWqSrudXZlzUsKY0Euz9DVEUIzzJtY6w0pCrtaPtft+CZJzkVgY6FqSGSRRegss5
 74OKIVoelgJfbXSxyjtex/wMg2/WKGRpJrfpo0kO7ncvWB9y5n98H5FsvwNE2p0PATDv
 P9evnixri/0QGqo+EW2Nj1LeKnyh17FyJ0u9OdC0oCK1+Aywo7iP5yBLoP+KmG/JNQGU
 I8bCEPaqzwoeH/0PjRHt5bDXEJyyPwgmA/R7ok+QLL/9Lt0yfK4YCcg1s73nl3O5HoHx
 QxFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrfTSWby5OaeG455drltFQ8bAuiOmwe3VmS2VLwb6sNoOnGzuXYBMLyi+yi6K1kfWUlD+sRkxOl7Y=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI1C7+OE1qGBjUvI7gGfSvO7HPj4KCx3tRfR8lmuJPPSQjSgQYN
 QvNkXl7NZRLkdLIeHRCn6lfkba/fIuOB/PLT/V0TTRxDUpmxKOdVB10+Xu04VklEXYhYeOvnPf8
 9WRrIZA2v1dFh5mkd1t1mhDqd+oznXeqyEp3eUllIJomj/BhgzFHxN6glAMeHvKlW9plZIOY=
X-Gm-Gg: AYBFou00HFfBurknrfuruJFLPvo/lRHWdGnfaB7kM4qIei/8hFAJ5sZj62PqIs2Nh7n
 ptqBnYQv3Xw1/U5PhtCsTZj4tcBv6F/jlrVl5A2eIafwSal/haiHu1Pk09RujhDC0ZZQ2+sG6Fw
 lz+gaVKAcnXN/dVSd1q8rBk3j1NODwxWIhqkL8mjIRAoFVHnhh5vlkM2cifwALs8lNe0GCcrtoh
 LebH8Vyhn9ieFrTn5DOVDN5oKHOnQH4SFJtCGU5csocA1f48UKbrFpO0EJEh5jUCfLPNu0kgNoO
 UArW8g+10a/8FOqsbmiKRYdCFPNR8tlYX6VKtyWI+nxsLHCvRmizu8DM99tKW0zY5JkSoYb/Ue5
 qVj4dgcLPRDvvYaZDsQ69m+tuAUgz5AtNF2POxo9PZJb4NTHN0A==
X-Received: by 2002:a05:7022:5f18:b0:143:298f:33b6 with SMTP id
 a92af1059eb24-16a6203ab5emr17121155c88.46.1791917781371; 
 Tue, 13 Oct 2026 11:56:21 -0700 (PDT)
X-Received: by 2002:a05:7022:5f18:b0:143:298f:33b6 with SMTP id
 a92af1059eb24-16a6203ab5emr17121056c88.46.1791917779716; 
 Tue, 13 Oct 2026 11:56:19 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1698de65af7sm43594045c88.0.2026.10.13.11.56.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 11:56:19 -0700 (PDT)
Message-ID: <e6a86bf0-86bd-4010-9d95-5b87bb2a3009@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:56:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Protect perf stats BO state with bo->lock
To: Shuvam Pandey <shuvampandey1@gmail.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <6a115824.a0bed9bd.3c0137.9edf@mx.google.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <6a115824.a0bed9bd.3c0137.9edf@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vqBgYL57iz5jUlTZNINSUnj4j-5zfvsw
X-Authority-Analysis: v=2.4 cv=FZuiV5+6 c=1 sm=1 tr=0 ts=6ace7ed6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=MIdiunF4UWRBeV6dtGUA:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3NSBTYWx0ZWRfX5cjXC58lijTW
 xA/KzorQP9aHqYcQyHHiU9/mNoUjB+Xhcu9ydVpSwhROX2Z1Ih3yG2igIcSd0AstTeP1/k1l14u
 8jXEfZRFXJihe+5sb5lb8mxFmyH0BB4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3NSBTYWx0ZWRfX+5+zL+6+vj4Z
 5pvGQGBzYB5jmaEIb1fQ+Ur2i1ZoC8E4Os2lfPC+rZepsOGDNvzeRcGhLfWhCnLkSWNq1sd88qH
 BjeImfmLkD25rcjIDVqeVbKuanJl3uhKrx5SJ8AdXp0qist7SX9T112awKXQhh19/BAI5u+B1k3
 XKWorfFn7j1FO/zdpzQ9ScjkxihuzJOR0nKMEdMYolUL6OHy2UOIQOjNONMmzkWoOUqTQkKJkSw
 /UgYXnByIake7wGygCAB4dYgoySBaSexwIjeUZpCj9j9KiuUS/KIZnrLW4z1HAM1EAD6nxl9xwd
 kwR8XGX8j2i+Xhxr+2a7BAqfZ1WIxrDp7nZL/OwRh8a3+qB3PISXvI7TE+llASP5XeJILWPprnn
 KkwlC/VQNIIgiw1RUoDE40qVpUlKNCg6cyV24Pp3qYvh2kTa/vmJT07VMw7ObL7urSZu0iMsQTC
 O9GoBTBADFmvbFWL0jQ==
X-Proofpoint-ORIG-GUID: vqBgYL57iz5jUlTZNINSUnj4j-5zfvsw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130075
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

On 5/23/2026 1:32 AM, Shuvam Pandey wrote:
> qaic_perf_stats_bo_ioctl() validates each BO by checking bo->sliced and
> bo->dbc before returning its perf stats. These fields are changed by the
> detach paths while holding bo->lock, but the perf stats ioctl reads them
> without that lock.
> 
> A concurrent detach can clear bo->dbc and mark the BO unsliced while the
> perf stats ioctl is validating the BO. Take bo->lock while checking the
> BO state and copying the per-BO stats into the temporary result buffer.
> 
> Fixes: 4ddf4ddfceb4 ("accel/qaic: Ensure entry belongs to DBC in qaic_perf_stats_bo_ioctl()")
> Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

Pushed to drm-misc-next.

-Jeff
