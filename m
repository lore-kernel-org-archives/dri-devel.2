Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15635CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3238710EF81;
	Thu, 28 May 2026 10:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RejT8wCN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RgI7FmR/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B1810EF80
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:12:14 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vUJC4016406
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AuMlQ94hzZYHxomsU+L+MfA3oE3xtzzIMmJ6zw8DcuY=; b=RejT8wCNdPCXNUbr
 XGZGjTn8BCWHFhCIFGuj5Dk2yHWcyJofFMJI0GgXn0mmR1VLJFSjHN3bsBFDC4dm
 owvJpQCZd3eodp+mwcoNqMkRFU/BT2sNWOlvF1NJt999EHVFtD0IjwNThT9P8+cy
 UqD5bfoRqLw7/ae0UBcCF+4p5M5gK58Edz2FCsxwi5LS89++FbcAFDjMNvCR1QMX
 n1O7Cm7Uedk1pDDhI24TFxjLfosmjIOyljZXSEpRVqpdsKYQmRMvD5ZMet+M3Bhr
 KAbCprsmlqln/JkRPd6MpVlZlBHIDguCaobrK52cgpaPZZBAzraKnmFrQB7CPZ1l
 IVMWJA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y5ab25-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:12:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-516d13328dcso131058811cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779963133; x=1780567933;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AuMlQ94hzZYHxomsU+L+MfA3oE3xtzzIMmJ6zw8DcuY=;
 b=RgI7FmR/vGSaFT0Vx4Fxl9HUw8qH9tKCWzXxZRHssBpVJBurqEqiGRbSytHghkuXnb
 87X4C3qtYKjnRH5dI2qjvqz/AONr5jfyiUp3yEsnoNsrQlGNChWN1RH1z5K3q0noM4Jn
 DdUJIwRHUP4JFfr2XeW9ZvsYXEcYrhzMEHqytB8dFUD2xEW/nBU+imIlLmkKBEY+aUS6
 fxsoTqzbANYoRGxsErRTLZqKympIgvKVfEZaJYwxlj670V4a0qII3mic8KURe+DlsDaR
 m/oixxDKvFy8NxQwDRFPQm7oTsoND0+ZApG2dYJcpmVm3qwuIAtWS0BrGKJI+Vu9XKDq
 oVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779963133; x=1780567933;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AuMlQ94hzZYHxomsU+L+MfA3oE3xtzzIMmJ6zw8DcuY=;
 b=lPoU9vG9gKO5EILnHoccRxk3wk7URegLQqpUzVIMjLUFv42DhTWJ2Lj22D6GiRwyoT
 aqYO4nuNhbEVfTOLroyWFZjojKyIcHkct0DbOWGC4O7tSBfPatgO5KXD8uwcn7ms3U6r
 Gl0v7/AUuVD9hn7YzHuEWiKZC0UX4Ra/rujuZlz6NONoaSMedhNsM8CL7CnK1XuThcUi
 RSiTLVhLUxFAHKsYx7QK7pq+eHYk7VtbySAJxw/Ozey5GfQpS0/dL8FS52i7yLKbckah
 qKEJbk+jJzrX+zfMooJGaXJ9VnyjsCbdde970nGKfsSn2Pr802ZwjRZZCocGQeWWotom
 D7TA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9QAHUgctcYOd07OLXmv+a7DJS7oBSdhsluab5u6JFiHHh1qht4+neKt53u34jDDNNa02b5/dBd8k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8aEsYLRF9zDF76RljiVQQDJ4NLqTce980kzra2KDpxFY+fk8z
 8imABdtqfKCn93Co7MIQxWkzZAORJgvY3kJaCTDFbrI3GNVz7Bau5SCdpLIUh6qeimpwAO+Kf2T
 +Zo+vJRo28r0xdEVcKbzrVVOhhsOoGYt9+2JibX3XHULXDrXR7t1mNfxLdthG0Zou+BIFFao=
X-Gm-Gg: Acq92OEXRExOxUdwckZgC6b5o+vIqZlWZKrXO3CIIjv+a0yEyjzNPFYNE6riTVTcPf8
 g7UO+frqvX16DOWfJqjfENKTxfnoNG7x1tnt8HA5ZTMQOu9tvsf3XlFN0+jiT/gGd9NwvrD8T86
 Hk75NJCuD2xe3HfKP9L9ZcxMO62CTqSR5/F4kza9wpLbSMLw2rK/V0Gt2wO34UebjWxWTYPfeuG
 9gJfpfwC7CC8MW0vTD3Gew2mS/J4Fy0fkmB4SrQYiR1iGBkvIGGtryHaHswGDFIXEemQWeIhTA3
 nlXt3zNa5BMZSTmmHwJ0wETrUgPcLzkwEEqdQy5wgNBl6R3mTD5CdrT2zCSURnO7OmGZ0l/AARR
 8jKIW9OJ7FOlVV6c6pwqaFjE3wBReZBQk9qptQelbhBGaRUTjag5JAPjLCdDSTRs7x5M9ON09LO
 locTqgGlzZ7NCRyO35ma6E9HicmEElFqXjnIJLTH9WjlQDBtIu9oREa7WXubWMYgt4G/qHPgVng
 J+kBpo/TgPRT+CLbERpEIKZuaw=
X-Received: by 2002:a05:622a:2298:b0:50f:c67e:d52c with SMTP id
 d75a77b69052e-516d466fc0cmr364940061cf.55.1779963133275; 
 Thu, 28 May 2026 03:12:13 -0700 (PDT)
X-Received: by 2002:a05:622a:2298:b0:50f:c67e:d52c with SMTP id
 d75a77b69052e-516d466fc0cmr364939791cf.55.1779963132858; 
 Thu, 28 May 2026 03:12:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:8e96:3679:b9c:de47?
 (2001-1c00-2a07-3a01-8e96-3679-0b9c-de47.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:2a07:3a01:8e96:3679:b9c:de47])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68a6faae4basm1682979a12.5.2026.05.28.03.12.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 03:12:11 -0700 (PDT)
Message-ID: <66a76d9f-fe04-4a72-b6fe-42c2922fe9d9@oss.qualcomm.com>
Date: Thu, 28 May 2026 12:12:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] clk: Add __clk_disable_unprepare_counts_only() and
 use this in simple[fb|drm]
To: Brian Masney <bmasney@redhat.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Helge Deller <deller@gmx.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
 <ahd4XgTo3KZqGS9M@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <ahd4XgTo3KZqGS9M@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OM4XGyaB c=1 sm=1 tr=0 ts=6a1814fd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=b01-GHMo7TsF7J3Xm3IA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 8cm87CXkRbGQePNwaScaWk4jCep7-Hkd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEwMyBTYWx0ZWRfX7F0lafx5EOoo
 7o8ARnLPu6kafY21CzohQYEZf1iCZTUD5ecAMnsmzCPOVNZ/FtgDE2iqd7FgUjBQgb2XZRYU19K
 fc5eahuYmvwA4xGSgFMyAxqFUTJEzaJM7x4ING8kg9BZLp59PBmx8j2dijRSej5mpk5d6wCKBTC
 htukDntWmcl6VwR0vh8G1tWPAe/As6n6QwIiPYV0HpkcHvr1JceupavmxPZH7IK644cnzOnFAdH
 npSoXzjXu189d1KWQZNw8CkS+kpNnhYul4EMDOxUnZFhI0PzNIqbBf8Eoefm4a7mH1iUGhbSDhF
 gbDwFWYgDCIePov8C/wEzIhmYB35Ycy5vuTxbh5N8QQCwhQCWgA17ZMj01rtaHAKLixsKnfuho5
 w1gEhTct1nZuJfrS5A26FRzlA2ALY998JXRZOhFRA1mpLJu+sINcEEX4i+SMu0txqeWpIybrI0w
 KlQup4gNsaAzpnjf0jw==
X-Proofpoint-GUID: 8cm87CXkRbGQePNwaScaWk4jCep7-Hkd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280103
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

Hi Brian,

On 28-May-26 1:03 AM, Brian Masney wrote:
> Hi Hans,
> 
> On Wed, May 27, 2026 at 11:48:08AM +0200, Hans de Goede wrote:
>> 2) One option considered was detaching the simple-framebuffer driver later,
>>    after the real display driver has had a chance to claim the clocks. But
>>    this won't work in cases where the real display driver picks different
>>    parent clocks then the boot firmware did and needs to reparent clocks.
> 
> Why won't that work in the case where different parent clocks are selected?
> I'll describe a scenario below.
> 
>>
>>    Basically the goal is for things to behave as if the simple-framebuffer
>>    driver was not there at all, because that leaves the hw in the state
>>    the real display driver expects.
> 
> I think the deferred unbinding could have some potential here where
> there is some kind of notification mechanism between simple-framebuffer
> and the real drm driver. So:
> 
> - simple-framebuffer driver takes reference(s) to the clk(s).
> 
> - real drm driver eventually loads, takes reference(s) to the necessary
>   clk(s).
> 
> - real drm driver sends a notification to simple-framebuffer that it's
>   done, and has control.
> 
> - simple-framebuffer can unbind and release its references to the clks.
> 
> No clks will be shutdown prematurely in this scenario.
> 
> If the real drm driver needs a different parent, then presumably things
> should be setup correctly, and simple-framebuffer can have the clocks
> shut down when it calls clk_disable_unprepare().

If the real drm driver needs a different parent, then how does it
do the reparenting while the simple-framebuffer driver is holding
a reference to the clock ?  In that case the clock might have
a protected_count of non 0 (depends on the core-clk flags) and
reparenting won't work.

We could have the drm driver claim the clks, then call some release
function and only then do the reparenting. But this makes things
somewhat complicated for the drm drivers.

So my conclusion is that having a clk equivalent of e.g.
pm_runtime_put_noidle() which just lowers the counts without
actually doing anything is still the most KISS approach here.

With the downside of needing a new clk-core function for this.

> If the real drm driver
> needed those clks, then it should hold a reference to them.
>
> I'm intentionally not going through how to do the notification mechanism> here.

Ack.

Regards,

Hans



