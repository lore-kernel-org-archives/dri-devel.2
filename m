Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474E0606A323
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fbL17svP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F4u8Sxyz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F90B10F923;
	Wed, 21 Oct 2026 06:06:16 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A5210F8EE
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:06:02 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5jAVR3711649
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=CG7vDeztCkMAf5IFzPiedWvi
 /+NNJKaJ0GebsubhhRE=; b=fbL17svPLA02SXj+tN7PR9n/h56fu6LBSWwJJc8o
 0lVEanxo8xU2ctnD9sDiZ0hRAtv2YxJlvAaxmYV5BP6LfpbCm8w6HloDrKJwIquo
 I8/DCMCMGaGtr5jT6zW1s7ADc1Ww+r9I2f3ldsikbKwlZ3wfmruviC/U2i3cZQF0
 k1zG4JQDYvwzqFO5JB1TF+A+MkS+YeYewKu+92P/rSSb0eAj4cgGzdT3CV/3jT4i
 DDuuytTdB8LaXC9TCImwHMPSZYIsRM7saVLa0vbD8wFe2LupnBJdcgAYrX6j5n8U
 Fy5NkCl8BvqomabzSvWvCHnBoO2V9+3v/Ymxvh81PvuuPQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v297d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:06:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cd61bdc8683so187946a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 23:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792562760; x=1793167560;
 darn=lists.freedesktop.org; 
 h=in-reply-to:from:cc:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CG7vDeztCkMAf5IFzPiedWvi/+NNJKaJ0GebsubhhRE=;
 b=F4u8SxyzbH2Mz9aU+U0bnChROoTVXWeAQ+GS53CAkDmypfAtoMVBSIXMtdU7eHKnpM
 YvLynRJ4+/8jrwYaCMHjQhh44bftI6gx6t1D67HbzQyH9ntLgZm0hm/b6TLsRlzgOsBb
 ijblyP6gJ7durNMpZ35gbydsDu4DNYR/mjdj41tK5JMReqyvOkjby9ZywWVL0dKBT9iA
 hRaaKWLqhV0X6Di8dqsi5C6h8WYR6DshM2a+ba/SrNVNG/hpEeanije39nB+bHUTZgRb
 tb0nnsDIWt4IThi4XE2FQxnHbDUiY8ahEiJgLQDflWGAElmt1l9FDImtxC0wwn71apXL
 JuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792562760; x=1793167560;
 h=in-reply-to:from:cc:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CG7vDeztCkMAf5IFzPiedWvi/+NNJKaJ0GebsubhhRE=;
 b=rhJhvxcI6h5vqH1l6lZz2p3C6exQa0tyjC36oKAo0Twu7sVB7yX1X3sdL5U0Iab5y0
 KiNwKXMvZPVGXGvB1eohtrXm7QLSHJO9cUSyuGeW6lbv/4lfkuHLtmpmIr28bbjTfFYL
 oQ9NgRJA+aQoHp0tBVIE/jbfyJVkUM1uCiExCNpdigdZ3uh8S7mPR0LaRy8vwQjOPj4G
 W0bUv8NZSPLPvdN83Fj+rqIvLxqT+JaO12FYt2FdahopsssCn2YgDqEART6MOObgIoLk
 JTWHRPGKoJsccfSKhc3rOXxkpZy5fNNBrVg5dmPhJbHi5u+wtqJ6uPC3Z6rMNavU20vg
 6Hqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHIraVULL9gLcXXd/VkMvOBdofZhR0b1O0s2W+rG5q4IoIsMHh+7bvus26zOBolmke9AQLJflEw10=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLVvK/FdhfyNTiw/hbwsqHo4IpFTyzBzntpLtTKO1IWWZrSyvd6
 lAX1RNx3ap4V2yfH+ffE/Nf7TSzQO1xU3vfAZGB6MZG2F64r2kiwrTR9bKfVzfYefOFDvi4wpHA
 mUiFBX3v0th27G6KjLkHbVabvHnfqtuoX+9sJ1IQvK3mNfRb4oE3bzTFQ2g/2mXw58YpQusY=
X-Gm-Gg: AYBFou00ysPfjOOyc+7CpYHzcz7OcDXUpAQbZyxI5q+SgLZSwz10fm0fPbbDqM9TpqX
 AIG76Zswzjf7PV9Ft+jjh5PCvBKpvvVanx25BTbnihCRWUIFzanIqk9gV7yAtSmK4jLWBb2gmns
 QJETcpjTFC2L126NV6YBlwg6fnl3ozgW773vMh5kexHrLE2vrS5y0EruCECSt2LOrGhJCsQjPaq
 oP4aSlYy4ZujR5MNFgmBJ0JjOLNGUuLreR82gtZ4Kp/MAgnM+VIvS3OYJd6upVApq2l1e7oz9yO
 jEflzA18vcC1PFtPU+g+m/miferFxGx9ydkX3Imoro1EzrWvtFZ9/QFpC9hmB6sIActdcDkWck4
 zxyRIXt6O+3QtcdkA33wXHAmZWg7uXXEemrIpYaAbJFQbXMUYpjottGSkrWJL8CaSZBhT2uA=
X-Received: by 2002:a05:6a20:a114:b0:3e2:100b:1043 with SMTP id
 adf61e73a8af0-3e287dffe95mr814971637.42.1792562759932; 
 Tue, 20 Oct 2026 23:05:59 -0700 (PDT)
X-Received: by 2002:a05:6a20:a114:b0:3e2:100b:1043 with SMTP id
 adf61e73a8af0-3e287dffe95mr814944637.42.1792562759336; 
 Tue, 20 Oct 2026 23:05:59 -0700 (PDT)
Received: from [10.133.33.149] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a0895dba2bsm423952b3a.36.2026.10.20.23.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 23:05:59 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------nPDeCru5XyWHOd300UNByDig"
Message-ID: <de46ee9c-a20a-40c2-b0a3-2507ac4038b5@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 14:05:54 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] misc: fastrpc: wake poll-mode waiters on SSR
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
References: <20261007084447.922-1-jianping.li@oss.qualcomm.com>
 <20261007084447.922-3-jianping.li@oss.qualcomm.com>
 <dfe968ea-d123-4e94-9a6a-5dbc21ae431c@oss.qualcomm.com>
Content-Language: en-US
Cc: arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>,
 thierry.escande@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com
From: Jianping Li <jianping.li@oss.qualcomm.com>
In-Reply-To: <dfe968ea-d123-4e94-9a6a-5dbc21ae431c@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyNCBTYWx0ZWRfX+ElM9VZYv6c4
 tE9oT+Qjx2Md9WYpiTBF8dC+AZUgBVFc7g37Yyy1Kyfsnve030iqldbb3dupkcucd/q0gq5M3CD
 JnXxpeyKN7bmT2fg7p/e7kKn4o5vhnY=
X-Proofpoint-ORIG-GUID: doiADRt_8pzUqqTI-SYGVUwWibcCVkEa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyNCBTYWx0ZWRfX+NbybUdd/n1/
 VbC8THZyNt103MN4ydOGeecaIimKZbVxLSDnmjySPMzAOK5g10KtGD9TjyM+tVx3ITTjC7xMYLJ
 dgkG/DzTOte5sQMdxxd2JWWDnBuZLl/dAcUs5l0DXmArmsLCmKCH/RcmGify2yHTOOEIlLj7UL3
 RKBPGg+8+//ODIkn5ojYXgSZJK5zI5X8nQBdM5YUEFnsUwNdDYc3QwR4M0Tyqf5FDsQDvcyG7Vm
 DAQyc+m2YiUOUeTd1LdndIYeYP+6n5H2y/kpMwVRnY3r2xVMxmUDymPEVsJiyKmqhWXPG7f5GhE
 kV35ubt9EeSD12wLThz3c7UC/hu0d7iqNh4N9xnzFjsb6/jORSwFJ/NHEBe+goE+JxiVuztWHm0
 VpoP5NjlDfdwgrgNzzaseNbwml529VAqMl43DasMAsUsk31oRnv3rry1GqeqI4ZSNKgb732J0Xp
 0W25t7jzuXt+QNcuyjA==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad85648 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=EUspDBNiAAAA:8 a=UnHifNDe3QSOt689MA0A:9 a=QEXdDO2ut3YA:10
 a=lWAaA6wL40FgRWs9ITUA:9 a=2WYdSOy4xX4CiBDs:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: doiADRt_8pzUqqTI-SYGVUwWibcCVkEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210024
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
--------------nPDeCru5XyWHOd300UNByDig
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/19/2026 3:25 PM, Ekansh Gupta wrote:
> On 07-10-2026 14:14, Jianping Li wrote:
>> fastrpc_notify_users() sets ctx->retval to -EPIPE and completes
>> ctx->work for every pending and interrupted context, which is enough to
>> release a thread blocked in fastrpc_wait_for_response().
>>
>> A thread using polling mode does not wait on that completion. It spins
>> in poll_for_remote_response(), whose exit condition is:
>>
>>    (val == FASTRPC_POLL_RESPONSE) || ctx->is_work_done
>>
>> Since the DSP is already down, it will never write FASTRPC_POLL_RESPONSE
>> into the poll address, and is_work_done is left untouched by
>> fastrpc_notify_users(). The thread therefore keeps spinning until
>> FASTRPC_POLL_MAX_TIMEOUT_US expires instead of bailing out immediately.
>>
>> Worse, the poll address lives inside ctx->buf, so a polling thread that
>> has not been told to stop is still reading a buffer that the SSR
>> teardown path is about to reclaim.
>>
>> Set is_work_done along with retval so polling waiters observe the
>> termination on their next iteration, exactly like completion waiters do.
>>
>> Signed-off-by: Jianping Li<jianping.li@oss.qualcomm.com>
> This looks to be a bug fix, can you please add Fixes: tag?

Thanks for the review. I'll add the Fixes tag in v2.

>
>> ---
>>   drivers/misc/fastrpc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 05b2e7e4ad3b..c54c450cb571 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -2663,6 +2663,7 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
>>   	spin_lock(&user->lock);
>>   	list_for_each_entry(ctx, &user->pending, node) {
>>   		ctx->retval = -EPIPE;
>> +		ctx->is_work_done = true;
>>   		complete(&ctx->work);
>>   	}
>>   	spin_unlock(&user->lock);
--------------nPDeCru5XyWHOd300UNByDig
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
    <div class="moz-cite-prefix">On 10/19/2026 3:25 PM, Ekansh Gupta
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:dfe968ea-d123-4e94-9a6a-5dbc21ae431c@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">On 07-10-2026 14:14, Jianping Li wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">fastrpc_notify_users() sets ctx-&gt;retval to -EPIPE and completes
ctx-&gt;work for every pending and interrupted context, which is enough to
release a thread blocked in fastrpc_wait_for_response().

A thread using polling mode does not wait on that completion. It spins
in poll_for_remote_response(), whose exit condition is:

  (val == FASTRPC_POLL_RESPONSE) || ctx-&gt;is_work_done

Since the DSP is already down, it will never write FASTRPC_POLL_RESPONSE
into the poll address, and is_work_done is left untouched by
fastrpc_notify_users(). The thread therefore keeps spinning until
FASTRPC_POLL_MAX_TIMEOUT_US expires instead of bailing out immediately.

Worse, the poll address lives inside ctx-&gt;buf, so a polling thread that
has not been told to stop is still reading a buffer that the SSR
teardown path is about to reclaim.

Set is_work_done along with retval so polling waiters observe the
termination on their next iteration, exactly like completion waiters do.

Signed-off-by: Jianping Li <a class="moz-txt-link-rfc2396E" href="mailto:jianping.li@oss.qualcomm.com">&lt;jianping.li@oss.qualcomm.com&gt;</a>
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This looks to be a bug fix, can you please add Fixes: tag?</pre>
    </blockquote>
    <pre wrap="" class="moz-quote-pre">Thanks for the review. I'll add the Fixes tag in v2.
<style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;</style></pre>
    <blockquote type="cite"
      cite="mid:dfe968ea-d123-4e94-9a6a-5dbc21ae431c@oss.qualcomm.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 05b2e7e4ad3b..c54c450cb571 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2663,6 +2663,7 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 	spin_lock(&amp;user-&gt;lock);
 	list_for_each_entry(ctx, &amp;user-&gt;pending, node) {
 		ctx-&gt;retval = -EPIPE;
+		ctx-&gt;is_work_done = true;
 		complete(&amp;ctx-&gt;work);
 	}
 	spin_unlock(&amp;user-&gt;lock);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------nPDeCru5XyWHOd300UNByDig--
