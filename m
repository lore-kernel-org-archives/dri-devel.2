Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11351CC6B20
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67E3510E41A;
	Wed, 14 Oct 2026 04:25:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5036210FAB5
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:24:52 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E1UvQe3017821
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R/YWOWusTmnn9Tx8/iLnPWjpANYDhhlrDY+RymDC9lQ=; b=mfBIXI1uLAOYHNpx
 M+pskrgQQbpJj/+60jNFLzZFxHw2r6RDPCnEYQak0C68FqNpjyua8eynX8SGcd1Y
 2J1k4+K/t/BHMHnNSVt94VWd+zjp21ADu/+gT5GHSxkze+TVoAJ8ZcEJUegyUcj3
 l02tjV+K80HtT6WpkHCz8hJA1pNAkGFI0embeDgtOOxCvfUQQ4c9lcW5zqnNjbim
 +IIDJbRdlgftjP27N4Ac7M+zpCtJs+D/UR8kPP45vYPVDrD5gR3xqxJhNmnwyIgi
 K4kI1TWbCLNx+Vt70sIiD4gGFEtC25wsPGiQD9gMthErtmViPMA3SxZL1fMU3msx
 O1ZOMA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s2b2cfk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:24:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e832c03576so63694725ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 21:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791951891; x=1792556691;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R/YWOWusTmnn9Tx8/iLnPWjpANYDhhlrDY+RymDC9lQ=;
 b=SIlgsmxDzHW6B6up7LOxPcwW7QZWEbKPyqWIA6zleaKE+S7SwIz85SYL4R35Etnnit
 awZu3SHxGAyig+Ddt/IYpOwXSyPZJs18knyszQ5pqmI1SwszZ7UWOoZXAVH2f9fFo0J8
 1mEQd4o2vJlo7el2aiYxb/cxv/nNphqawFWiRYH32psWNoEeoAG5qIQ30a4Nk5VxAFa5
 zAsl4SNBS3hINTo9Mr1WIBZf/fIC/+0EPYkTdMZoJo/7/h69xQvxO3MFpqBYY+AMANXO
 Ka69RGWW5IWA523lantHfckX4i8TPF8ukm8i466bNQa7emociShpAdLLErk2jUUDCgFz
 EMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791951891; x=1792556691;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R/YWOWusTmnn9Tx8/iLnPWjpANYDhhlrDY+RymDC9lQ=;
 b=Na8BcgdcpCEgNpJ/R4Z7jAQTDpM/C/gMQmEyBK3f3FDvllTxNlG9EPsDalHyTwbFMO
 ktJFDY3BA9DeljbWT/hDw9qUArP9p1aJCxHtFu6lOARR9mYh48tVloFerexrJiR0l7m1
 Q5fvGkDSWZQZEByGi7gb9bXobqo2OK/ZmmvOP68RxWRl/0W8Hcg1YpNSTEFGfbiTwNw+
 MrSXiyvO5QtrznmT0s55rAP0wyrmfKbuSX45zrK1KOaI6hxgTjh+DsQMi8dfmH5EXiiu
 Pf93E6mdHl2doog1N5MVM/gSd17ZlLtyEDCRN2fu5A0Ba6msRlCQVRz/MA/H0T2hyA3K
 DbNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdYkvoeXs28EWlgR8XBNgyVHS1cLtqtxe8HjjgNvkv7EZK6GKykjMniOHmKZEAxImjFFhRMzkC3Io=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJgKbEabr+EX5ixEaOCXKwKKTfmfo0igOvgORBC825qK8FsNHTC
 xUw+XqUd7J3IK2gRP0XtWXA7PAdSdj0GQrwqJ1r7AsD2RpihOLv9q3WLp9ioSaX63oIzMCIgE0f
 DIwyxT20vUFyrBjehLCbKLgzQKvdWPmdF5gej7m+kLCkYPfrKXV+fE8E+cz4tJX88RKIhNrw=
X-Gm-Gg: AYBFou2awnyPGMi74uw56FFa6Av8MCrl7OeghfNZwW3pZaDSvxJtAwI7yFIVYbbl6wP
 vmjqpUZBoyk+AohMiMUeR3WHBZ2ktSlMdZPoEFV7Rqo6YGROYtgbgJ78WvYol9U2aYm7Kaf+QS7
 JGT98rA0sjSIzK8Av4dIjGTBjQnuU/pLeQqVh3ZdRIFX+rWAAQslHR7ob8gPB1W/DNl1WP83Vlm
 3jZIchsMRhqRkjTQKvYZj8pQAxlRyU0iCER9ETbK4WKEoNsFsqAqL4b4E9jXRLqji5maNfFeWiL
 +3YbIyfmcvXE6JzKjbM874DXBi2vy25fjRDJLY1y70QiyDP2ZxIacXAjIO9RPn/7saHHbk919pD
 xZKIYbExQmM6kv6Byd4NZy2vcdKkEIA4s9fR/Or6rjWy67Q7d3qLNop9FKTlvwts0AUsLSCvI
X-Received: by 2002:a17:90b:35cc:b0:3a5:147a:3b63 with SMTP id
 98e67ed59e1d1-3ab3a33db36mr12329625a91.8.1791951890979; 
 Tue, 13 Oct 2026 21:24:50 -0700 (PDT)
X-Received: by 2002:a17:90b:35cc:b0:3a5:147a:3b63 with SMTP id
 98e67ed59e1d1-3ab3a33db36mr12329579a91.8.1791951890405; 
 Tue, 13 Oct 2026 21:24:50 -0700 (PDT)
Received: from [10.133.33.242] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac63279277sm860530a91.1.2026.10.13.21.24.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 21:24:49 -0700 (PDT)
Message-ID: <252e86f2-9663-4ac7-a19e-6056b44e769b@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 12:24:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] cpufreq: Initialize kobj_type release callback in
 ondemand and conservative governors
To: Ian Rogers <irogers@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Viresh Kumar <viresh.kumar@linaro.org>, David Teigland
 <teigland@redhat.com>,
 Alexander Aring <aahringo@redhat.com>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>,
 Zhihao Cheng <chengzhihao1@huawei.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 driver-core@lists.linux.dev, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 gfs2@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-5-irogers@google.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261013223946.1836757-5-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RPQmjIi+ c=1 sm=1 tr=0 ts=6acf0413 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=1XWaLZrsAAAA:8 a=Stt4M9KXtKJ5ZbChFzoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: cFKA6G8E2IPnDfvWaIE3pdM4UH173adc
X-Proofpoint-ORIG-GUID: cFKA6G8E2IPnDfvWaIE3pdM4UH173adc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNyBTYWx0ZWRfXzDp3kVh1Bvpp
 yAIMD3vFYj/aYDoafIjGxzyC2JQy+DNR69Kt8sbLIeuV1wtRZuIKlENl0gIjB7zjuEV3JS7teLL
 OWGv0CmD1ew/1v/ZzBsAyXyx+AQ1F1tn57wUqFgcFiEzD3PDEMDsnera9/cW3VKdFD/PghQX6j5
 HJ552dyI605HJPVcxiQ1P42xOs23hjQmvk8k+vMODZG1XoILIvcmvT+Rej4ME2MI1hf0R+h5dHq
 bb55Vy0gBHaTpNksCBhjt6o0JrxC8g518CBa85JQ0i5lRjZ36GeJYIhim3lptq7ETlBf7yeqsuC
 HpMYT/njxb/9kxCpXBEET0XhDAJslRQdSizGnSzhZmVFr1J5MZvUa2CB5/LZ+xm/r42vgzbWic/
 Ne4EI3GJr0ecJewcm7HoYIGw4UgdbPQPiiw12HikV0nxYUbBHSx/iUnvKXYbVyI6MIyd7oJZw0o
 I8/F5xhosZyq3wF3i8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNyBTYWx0ZWRfXzbpirnXo2zz2
 xJqLruREqz785KPBBJryTEuHxwNc3Ji45ByGVbhXNvk6kQJJPmvoXtpAivAzjFVVE4xqEtYUWW4
 mkI4sreSDiA6yaO65blfzKymtCg+fNo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140017
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

Hi Ian,

Thanks a lot for the patch.

On 10/14/2026 6:39 AM, Ian Rogers wrote:
> Export cpufreq_dbs_data_release() and set .kobj_type.release in the
> ondemand and conservative governors so their gov_attr_set kobjects have
> a valid release callback, matching cpufreq_ governor_dbs.

Commit a85ee6401a47 ("cpufreq: governor: Use kobject release() method to
free dbs_data") has already addressed the missing release callback
issue(it adds the missing cpufreq_dbs_data_release() function.), with 
its Fixes tag pointing to c4435630361d.

Besides, "matching cpufreq_ governor_dbs." seems to be a typo?

> 
> This prepares for annotating struct kobj_type::release with
> __require_explicit_initialization.

It would be better to use "cpufreq: governor:" as the subject prefix.

> 
> Fixes: c4435630361d ("cpufreq: governor: New sysfs show/store callbacks for governor tunables")

Since a85ee6401a47 ("cpufreq: governor: Use kobject release() method to
free dbs_data") has already fixed the missing release callback issue,
current cpufreq patch 4/11 seems to only move the release callback
initialization to the static initializer in preparation for 11/11. The
same callback is already set at runtime in cpufreq_dbs_governor_init(),
so there is no functional change or bug fix here. Should we drop the
Fixes tag?

So, at least for cpufreq, the issue described in the cover letter
doesn't seem to exist, right?

"Patches 2-10 fix 10 struct kobj_type definitions where dynamically
allocated kobjects, ksets, or enclosing structures were either leaked on
kobject_put() or freed prematurely before kobject release"


> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
>   drivers/cpufreq/cpufreq_governor.c     | 3 ++-
>   drivers/cpufreq/cpufreq_governor.h     | 1 +
>   drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
>   4 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 0b32ae28ec85..38c3bd5bf75a 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -316,7 +316,10 @@ static void cs_limits(struct cpufreq_policy *policy)
>   
>   static struct dbs_governor cs_governor = {
>   	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> -	.kobj_type = { .default_groups = cs_groups },
> +	.kobj_type = {
> +		.release = cpufreq_dbs_data_release,
> +		.default_groups = cs_groups,
> +	},

Nit: In that case, may I know can we also remove the following runtime
assignment from cpufreq_dbs_governor_init() as below:

gov->kobj_type.release = cpufreq_dbs_data_release;


>   	.gov_dbs_update = cs_dbs_update,
>   	.alloc = cs_alloc,
>   	.free = cs_free,
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 710d93ec89b5..97b64985927d 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -404,7 +404,7 @@ static void free_policy_dbs_info(struct policy_dbs_info *policy_dbs,
>   	gov->free(policy_dbs);
>   }
>   
> -static void cpufreq_dbs_data_release(struct kobject *kobj)
> +void cpufreq_dbs_data_release(struct kobject *kobj)
>   {
>   	struct dbs_data *dbs_data = to_dbs_data(to_gov_attr_set(kobj));
>   	struct dbs_governor *gov = dbs_data->gov;
> @@ -412,6 +412,7 @@ static void cpufreq_dbs_data_release(struct kobject *kobj)
>   	gov->exit(dbs_data);
>   	kfree(dbs_data);
>   }
> +EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
>   
>   int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>   {
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index 73b8ed7cfaae..c03d067f42eb 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -148,6 +148,7 @@ static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy
>   }
>   
>   /* Governor callback routines */
> +void cpufreq_dbs_data_release(struct kobject *kobj);
>   int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
>   void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
>   int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index 9942dbb38dae..7386d043c665 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -374,7 +374,10 @@ static struct od_ops od_ops = {
>   
>   static struct dbs_governor od_dbs_gov = {
>   	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> -	.kobj_type = { .default_groups = od_groups },
> +	.kobj_type = {
> +		.release = cpufreq_dbs_data_release,
> +		.default_groups = od_groups,
> +	},
>   	.gov_dbs_update = od_dbs_update,
>   	.alloc = od_alloc,
>   	.free = od_free,


-- 
Thx and BRs,
Zhongqiu Han
