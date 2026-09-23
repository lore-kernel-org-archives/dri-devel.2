Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63C6C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DE6510E983;
	Wed, 23 Sep 2026 17:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mPz7APEo";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 970B610E983
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 17:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=kr82gAtDWQsFhFTzh++ecF7KNCv6SHJZ4KYvkUmmoA8=; b=mPz7APEoNu2hV4NuzK9RuVS4Sc
 ltV+0nzvflG5GW55HuKqBe8eVsMJrw5p01l7rObXp5busefVLrCBOH6poEaKnpGQjEjusaQ/Hx6Q/
 7jukF2iOG2sq5sSwiQ7vJ3XSidc/Pv8rnxNeWyL/V7LuV+60q2hZhACxIASR/YAlvCUpvkDe6DXSS
 LsxzS1rPGmwozrLbuFVXnN8ifqaq2FD5ozQ46rTdYhNjOdJPRNdwrKo+cdIWuV8ckX5kR2YsHjbBk
 qU326C2oacKqbiR1O+m58aKZscakiBt++F8+l/nCEw8zZGV4aDBXmm8aBgNYza0i8NbQ+8TkzIcXN
 IV7VaPcQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x9QW4-006Ff0-Ax; Wed, 23 Sep 2026 19:12:20 +0200
Message-ID: <282b1fc2-3305-4784-8f83-0f3bc461ec18@igalia.com>
Date: Wed, 23 Sep 2026 18:12:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 1/3] workqueue: Simplify unbound sysfs attribute
 registration
To: linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Tejun Heo <tj@kernel.org>
References: <20260923161251.45428-1-tvrtko.ursulin@igalia.com>
 <20260923161251.45428-2-tvrtko.ursulin@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260923161251.45428-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 23/09/2026 17:12, Tvrtko Ursulin wrote:
> Instead of manually registering each attribute we can put them in an
> attribute group with a visibility check and device core will handle the
> rest, which simplifies the registration and error unwind.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Bradley Morgan <include@grrlz.net>
> Cc: Chia-I Wu <olv@google.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Tejun Heo <tj@kernel.org>
> ---
>   kernel/workqueue.c | 98 ++++++++++++++++++++++++----------------------
>   1 file changed, 52 insertions(+), 46 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index e618108c6127..e3a4ad56dae8 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -7599,8 +7599,8 @@ static const struct attribute_group wq_sysfs_group = {
>   };
>   __ATTRIBUTE_GROUPS(wq_sysfs);
>   
> -static ssize_t wq_nice_show(struct device *dev, struct device_attribute *attr,
> -			    char *buf)
> +static ssize_t nice_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
>   {
>   	struct workqueue_struct *wq = dev_to_wq(dev);
>   	int written;
> @@ -7627,8 +7627,8 @@ static struct workqueue_attrs *wq_sysfs_prep_attrs(struct workqueue_struct *wq)
>   	return attrs;
>   }
>   
> -static ssize_t wq_nice_store(struct device *dev, struct device_attribute *attr,
> -			     const char *buf, size_t count)
> +static ssize_t nice_store(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t count)
>   {
>   	struct workqueue_struct *wq = dev_to_wq(dev);
>   	struct workqueue_attrs *attrs;
> @@ -7652,8 +7652,8 @@ static ssize_t wq_nice_store(struct device *dev, struct device_attribute *attr,
>   	return ret ?: count;
>   }
>   
> -static ssize_t wq_cpumask_show(struct device *dev,
> -			       struct device_attribute *attr, char *buf)
> +static ssize_t unbound_cpumask_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
>   {
>   	struct workqueue_struct *wq = dev_to_wq(dev);
>   	int written;
> @@ -7665,9 +7665,9 @@ static ssize_t wq_cpumask_show(struct device *dev,
>   	return written;
>   }
>   
> -static ssize_t wq_cpumask_store(struct device *dev,
> -				struct device_attribute *attr,
> -				const char *buf, size_t count)
> +static ssize_t unbound_cpumask_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
>   {
>   	struct workqueue_struct *wq = dev_to_wq(dev);
>   	struct workqueue_attrs *attrs;
> @@ -7689,8 +7689,8 @@ static ssize_t wq_cpumask_store(struct device *dev,
>   	return ret ?: count;
>   }
>   
> -static ssize_t wq_affn_scope_show(struct device *dev,
> -				  struct device_attribute *attr, char *buf)
> +static ssize_t affn_scope_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
>   {
>   	struct workqueue_struct *wq = dev_to_wq(dev);
>   	int written;
> @@ -7708,9 +7708,9 @@ static ssize_t wq_affn_scope_show(struct device *dev,
>   	return written;
>   }
>   
> -static ssize_t wq_affn_scope_store(struct device *dev,
> -				   struct device_attribute *attr,
> -				   const char *buf, size_t count)
> +static ssize_t affn_scope_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
>   {
>   	struct workqueue_struct *wq = dev_to_wq(dev);
>   	struct workqueue_attrs *attrs;
> @@ -7731,8 +7731,8 @@ static ssize_t wq_affn_scope_store(struct device *dev,
>   	return ret ?: count;
>   }
>   
> -static ssize_t wq_affinity_strict_show(struct device *dev,
> -				       struct device_attribute *attr, char *buf)
> +static ssize_t affinity_strict_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
>   {
>   	struct workqueue_struct *wq = dev_to_wq(dev);
>   
> @@ -7740,9 +7740,9 @@ static ssize_t wq_affinity_strict_show(struct device *dev,
>   			 wq->attrs->affn_strict);
>   }
>   
> -static ssize_t wq_affinity_strict_store(struct device *dev,
> -					struct device_attribute *attr,
> -					const char *buf, size_t count)
> +static ssize_t affinity_strict_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
>   {
>   	struct workqueue_struct *wq = dev_to_wq(dev);
>   	struct workqueue_attrs *attrs;
> @@ -7762,14 +7762,40 @@ static ssize_t wq_affinity_strict_store(struct device *dev,
>   	return ret ?: count;
>   }
>   
> -static struct device_attribute wq_sysfs_unbound_attrs[] = {
> -	__ATTR(nice, 0644, wq_nice_show, wq_nice_store),
> -	__ATTR(cpumask, 0644, wq_cpumask_show, wq_cpumask_store),
> -	__ATTR(affinity_scope, 0644, wq_affn_scope_show, wq_affn_scope_store),
> -	__ATTR(affinity_strict, 0644, wq_affinity_strict_show, wq_affinity_strict_store),
> -	__ATTR_NULL,
> +static DEVICE_ATTR_RW(nice);
> +static DEVICE_ATTR_RW(affn_scope);

Sashiko on dri-devel pointed out I blundered with the accidental rename 
here. But lets first see if people think this simplification is desired 
to begin with. I think it is nicer than having to suppress and re-enable 
uvents, and unwind on errors, plus, it's handy for the WQ_RTPRI patch to 
restrict write access to the nice attribute.

Regards,

Tvrtko

> +static DEVICE_ATTR_RW(affinity_strict);
> +/* Avoid naming clash with the other cpumask */
> +static struct device_attribute dev_attr_unbound_cpumask =
> +	__ATTR(cpumask, 0644, unbound_cpumask_show, unbound_cpumask_store);
> +
> +static struct attribute *wq_sysfs_unbound_attrs[] = {
> +	&dev_attr_nice.attr,
> +	&dev_attr_unbound_cpumask.attr,
> +	&dev_attr_affn_scope.attr,
> +	&dev_attr_affinity_strict.attr,
> +	NULL,
>   };
>   
> +static umode_t wq_sysfs_unbound_group_visible(struct kobject *kobj,
> +					      struct attribute *attr, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct workqueue_struct *wq = dev_to_wq(dev);
> +
> +	if (!(wq->flags & WQ_UNBOUND))
> +		return SYSFS_GROUP_INVISIBLE;
> +
> +	return attr->mode;
> +}
> +
> +static const struct attribute_group wq_sysfs_unbound_group = {
> +	.is_visible = wq_sysfs_unbound_group_visible,
> +	.attrs = wq_sysfs_unbound_attrs,
> +};
> +
> +__ATTRIBUTE_GROUPS(wq_sysfs_unbound);
> +
>   static const struct bus_type wq_subsys = {
>   	.name				= "workqueue",
>   	.dev_groups			= wq_sysfs_groups,
> @@ -7907,14 +7933,9 @@ int workqueue_sysfs_register(struct workqueue_struct *wq)
>   	wq_dev->wq = wq;
>   	wq_dev->dev.bus = &wq_subsys;
>   	wq_dev->dev.release = wq_device_release;
> +	wq_dev->dev.groups = wq_sysfs_unbound_groups;
>   	dev_set_name(&wq_dev->dev, "%s", wq->name);
>   
> -	/*
> -	 * attrs are created separately.  Suppress uevent until
> -	 * everything is ready.
> -	 */
> -	dev_set_uevent_suppress(&wq_dev->dev, true);
> -
>   	ret = device_register(&wq_dev->dev);
>   	if (ret) {
>   		put_device(&wq_dev->dev);
> @@ -7922,21 +7943,6 @@ int workqueue_sysfs_register(struct workqueue_struct *wq)
>   		return ret;
>   	}
>   
> -	if (wq->flags & WQ_UNBOUND) {
> -		struct device_attribute *attr;
> -
> -		for (attr = wq_sysfs_unbound_attrs; attr->attr.name; attr++) {
> -			ret = device_create_file(&wq_dev->dev, attr);
> -			if (ret) {
> -				device_unregister(&wq_dev->dev);
> -				wq->wq_dev = NULL;
> -				return ret;
> -			}
> -		}
> -	}
> -
> -	dev_set_uevent_suppress(&wq_dev->dev, false);
> -	kobject_uevent(&wq_dev->dev.kobj, KOBJ_ADD);
>   	return 0;
>   }
>   

