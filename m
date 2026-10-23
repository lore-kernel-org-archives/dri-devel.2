Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E636B606A321
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=C5oZPJfr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5430410E5FF;
	Fri, 23 Oct 2026 13:15:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 23DE510E5FF
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:14:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 773DB31DB
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:14:50 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 742143F673
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792761293; bh=UQ5/3tBMTbpg8C8cu7Y5xDvLCqAOImajR7a717b4m94=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C5oZPJfrVm0BsBP9FR9zCAIRvvErwEIYMg3OA1Eossbg9V0GotoWOzO6DZDMX0zKw
 wNIeLtV/j6f1dcp4sk+ljB2fvip6yVZxQIDen6wHaFkJA7lFZW1xNAb3SyI5w6xK4G
 7NXnUO6W1PjQDI9j8HCXInpWwcrqQg/RpiHkiqe8=
Date: Fri, 23 Oct 2026 14:14:50 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v7 1/4] workqueue: Simplify unbound sysfs attribute
 registration
Message-ID: <attdyi_ghyPWJQJv@e142607>
References: <20261022093848.5727-1-tvrtko.ursulin@igalia.com>
 <20261022093848.5727-2-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261022093848.5727-2-tvrtko.ursulin@igalia.com>
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 10:38:45AM +0100, Tvrtko Ursulin wrote:
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

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> v2:
>  * Fix accidental rename of affinity_scope.
> 
> v3:
>  * SYSFS_GROUP_INVISIBLE should not be used for un-named groups.
> ---
>  kernel/workqueue.c | 98 ++++++++++++++++++++++++----------------------
>  1 file changed, 52 insertions(+), 46 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 41754f4126a6..d8cf546d853f 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -7599,8 +7599,8 @@ static const struct attribute_group wq_sysfs_group = {
>  };
>  __ATTRIBUTE_GROUPS(wq_sysfs);
>  
> -static ssize_t wq_nice_show(struct device *dev, struct device_attribute *attr,
> -			    char *buf)
> +static ssize_t nice_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
>  {
>  	struct workqueue_struct *wq = dev_to_wq(dev);
>  	int written;
> @@ -7627,8 +7627,8 @@ static struct workqueue_attrs *wq_sysfs_prep_attrs(struct workqueue_struct *wq)
>  	return attrs;
>  }
>  
> -static ssize_t wq_nice_store(struct device *dev, struct device_attribute *attr,
> -			     const char *buf, size_t count)
> +static ssize_t nice_store(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t count)
>  {
>  	struct workqueue_struct *wq = dev_to_wq(dev);
>  	struct workqueue_attrs *attrs;
> @@ -7652,8 +7652,8 @@ static ssize_t wq_nice_store(struct device *dev, struct device_attribute *attr,
>  	return ret ?: count;
>  }
>  
> -static ssize_t wq_cpumask_show(struct device *dev,
> -			       struct device_attribute *attr, char *buf)
> +static ssize_t unbound_cpumask_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
>  {
>  	struct workqueue_struct *wq = dev_to_wq(dev);
>  	int written;
> @@ -7665,9 +7665,9 @@ static ssize_t wq_cpumask_show(struct device *dev,
>  	return written;
>  }
>  
> -static ssize_t wq_cpumask_store(struct device *dev,
> -				struct device_attribute *attr,
> -				const char *buf, size_t count)
> +static ssize_t unbound_cpumask_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
>  {
>  	struct workqueue_struct *wq = dev_to_wq(dev);
>  	struct workqueue_attrs *attrs;
> @@ -7689,8 +7689,8 @@ static ssize_t wq_cpumask_store(struct device *dev,
>  	return ret ?: count;
>  }
>  
> -static ssize_t wq_affn_scope_show(struct device *dev,
> -				  struct device_attribute *attr, char *buf)
> +static ssize_t affinity_scope_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
>  {
>  	struct workqueue_struct *wq = dev_to_wq(dev);
>  	int written;
> @@ -7708,9 +7708,9 @@ static ssize_t wq_affn_scope_show(struct device *dev,
>  	return written;
>  }
>  
> -static ssize_t wq_affn_scope_store(struct device *dev,
> -				   struct device_attribute *attr,
> -				   const char *buf, size_t count)
> +static ssize_t affinity_scope_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
>  {
>  	struct workqueue_struct *wq = dev_to_wq(dev);
>  	struct workqueue_attrs *attrs;
> @@ -7731,8 +7731,8 @@ static ssize_t wq_affn_scope_store(struct device *dev,
>  	return ret ?: count;
>  }
>  
> -static ssize_t wq_affinity_strict_show(struct device *dev,
> -				       struct device_attribute *attr, char *buf)
> +static ssize_t affinity_strict_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
>  {
>  	struct workqueue_struct *wq = dev_to_wq(dev);
>  
> @@ -7740,9 +7740,9 @@ static ssize_t wq_affinity_strict_show(struct device *dev,
>  			 wq->attrs->affn_strict);
>  }
>  
> -static ssize_t wq_affinity_strict_store(struct device *dev,
> -					struct device_attribute *attr,
> -					const char *buf, size_t count)
> +static ssize_t affinity_strict_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
>  {
>  	struct workqueue_struct *wq = dev_to_wq(dev);
>  	struct workqueue_attrs *attrs;
> @@ -7762,14 +7762,40 @@ static ssize_t wq_affinity_strict_store(struct device *dev,
>  	return ret ?: count;
>  }
>  
> -static struct device_attribute wq_sysfs_unbound_attrs[] = {
> -	__ATTR(nice, 0644, wq_nice_show, wq_nice_store),
> -	__ATTR(cpumask, 0644, wq_cpumask_show, wq_cpumask_store),
> -	__ATTR(affinity_scope, 0644, wq_affn_scope_show, wq_affn_scope_store),
> -	__ATTR(affinity_strict, 0644, wq_affinity_strict_show, wq_affinity_strict_store),
> -	__ATTR_NULL,
> +static DEVICE_ATTR_RW(nice);
> +static DEVICE_ATTR_RW(affinity_scope);
> +static DEVICE_ATTR_RW(affinity_strict);
> +/* Avoid naming clash with the other cpumask */
> +static struct device_attribute dev_attr_unbound_cpumask =
> +	__ATTR(cpumask, 0644, unbound_cpumask_show, unbound_cpumask_store);
> +
> +static struct attribute *wq_sysfs_unbound_attrs[] = {
> +	&dev_attr_nice.attr,
> +	&dev_attr_unbound_cpumask.attr,
> +	&dev_attr_affinity_scope.attr,
> +	&dev_attr_affinity_strict.attr,
> +	NULL,
>  };
>  
> +static umode_t wq_sysfs_unbound_group_visible(struct kobject *kobj,
> +					      struct attribute *attr, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct workqueue_struct *wq = dev_to_wq(dev);
> +
> +	if (!(wq->flags & WQ_UNBOUND))
> +		return 0;
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
>  static const struct bus_type wq_subsys = {
>  	.name				= "workqueue",
>  	.dev_groups			= wq_sysfs_groups,
> @@ -7907,14 +7933,9 @@ int workqueue_sysfs_register(struct workqueue_struct *wq)
>  	wq_dev->wq = wq;
>  	wq_dev->dev.bus = &wq_subsys;
>  	wq_dev->dev.release = wq_device_release;
> +	wq_dev->dev.groups = wq_sysfs_unbound_groups;
>  	dev_set_name(&wq_dev->dev, "%s", wq->name);
>  
> -	/*
> -	 * attrs are created separately.  Suppress uevent until
> -	 * everything is ready.
> -	 */
> -	dev_set_uevent_suppress(&wq_dev->dev, true);
> -
>  	ret = device_register(&wq_dev->dev);
>  	if (ret) {
>  		put_device(&wq_dev->dev);
> @@ -7922,21 +7943,6 @@ int workqueue_sysfs_register(struct workqueue_struct *wq)
>  		return ret;
>  	}
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
>  	return 0;
>  }
>  
> -- 
> 2.56.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
