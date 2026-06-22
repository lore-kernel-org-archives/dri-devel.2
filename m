Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A718FCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17F9110E748;
	Mon, 22 Jun 2026 15:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rX8D0zjG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A51F10E748
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lYn+4xQVfRuq8Ml30rRgcmwKACArqKVZchit736X3bU=; b=rX8D0zjG+NiriNeE5ndVfrEanZ
 xhoRf3qy+Mcu1qj5e09fIlra/C/S+9YqOa61qhhBL4Iln8kS8oNNRbOvE8f7Rjxpsw3gir8KV4crt
 7tbctZm0HwGNePEffqtqU7zwvHElix6F4QC3dO4N8WvVSgoLF41QFoU95VphDP6tkXMtZbq9kBnkk
 J60X/zam9QtVUKW68evkKJ71Nsox6NdchGRwM7shY7Jq5B7ToLJVY8vFObyrWf+Dwf62bgWyaZvS9
 W0zKhDSWcMzzRr654iOXzj46WsvHjR26m3PrDRWseTtzPtEKnZkhvDktqDgYhyvGtJzgO+EGNpqvV
 sbiTpMvg==;
Received: from 179-125-64-254-dinamico.pombonet.net.br ([179.125.64.254]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wbgLt-003n6D-7f; Mon, 22 Jun 2026 17:14:21 +0200
Date: Mon, 22 Jun 2026 12:14:13 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Eric Chanudet <echanude@redhat.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH v2] cgroup/dmem: accept only one region per limit write
Message-ID: <ajlRRZ6YCulTBbEb@quatroqueijos.cascardo.eti.br>
References: <20260608-cgroup-dmem-write-single-region-v2-1-b0cd6c4ccf1b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-cgroup-dmem-write-single-region-v2-1-b0cd6c4ccf1b@redhat.com>
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

On Mon, Jun 08, 2026 at 11:53:51AM -0400, Eric Chanudet wrote:
> Accept only one "region value" pair entry for the dmem.max, dmem.min,
> dmem.low files.
> 
> This changes the UAPI that otherwise accepted multiple lines for setting
> multiple entries in one write. No existing user is known to rely on
> writing multiple regions in a single write.
> 
> Processing multiple regions in dmemcg_limit_write() could quietly change
> first limits before failing on a later one and returning an error to the
> writer, with no indication some changes occurred.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Eric Chanudet <echanude@redhat.com>

I did some review over any potential NULL derefs and tested with different
corner cases. I could not find any issues.

Thanks.
Cascardo.

Reviewed-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Tested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

> ---
> Follow up from discussions on a previous thread[1].
> If Albert's series[2] lands, I can cleanup and prepare some kunits for
> these as well.
> [1] https://lore.kernel.org/all/158bc103-7f99-4df4-8d3b-2da9b04ac0ed@lankhorst.se/
> [2] https://lore.kernel.org/all/20260519-kunit_cgroups-v4-1-f6c2f498fae4@redhat.com/
> ---
> Changes in v2:
> - Handle buf == NULL by testing !buf first after strsep (Natalie)
> - Don't allow extra spaces to separate key and value (Natalie)
>   Other cgroup files don't (rdma, misc), so stay consistent.
> - Link to v1: https://lore.kernel.org/r/20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com
> ---
>  kernel/cgroup/dmem.c | 69 +++++++++++++++++++---------------------------------
>  1 file changed, 25 insertions(+), 44 deletions(-)
> 
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 6430c7ce1e0372f59f1313163fb7630ce49ac1ef..39930c59cb769a505a5852a5644a371fd5596f59 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -734,57 +734,38 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
>  				 void (*apply)(struct dmem_cgroup_pool_state *, u64))
>  {
>  	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
> -	int err = 0;
> -
> -	while (buf && !err) {
> -		struct dmem_cgroup_pool_state *pool = NULL;
> -		char *options, *region_name;
> -		struct dmem_cgroup_region *region;
> -		u64 new_limit;
> -
> -		options = buf;
> -		buf = strchr(buf, '\n');
> -		if (buf)
> -			*buf++ = '\0';
> -
> -		options = strstrip(options);
> -
> -		/* eat empty lines */
> -		if (!options[0])
> -			continue;
> -
> -		region_name = strsep(&options, " \t");
> -		if (!region_name[0])
> -			continue;
> -
> -		if (!options || !*options)
> -			return -EINVAL;
> +	struct dmem_cgroup_pool_state *pool;
> +	struct dmem_cgroup_region *region;
> +	char *region_name;
> +	u64 new_limit;
> +	int err;
>  
> -		rcu_read_lock();
> -		region = dmemcg_get_region_by_name(region_name);
> -		rcu_read_unlock();
> +	buf = strstrip(buf);
> +	region_name = strsep(&buf, " \t");
> +	if (!buf || !region_name[0])
> +		return -EINVAL;
>  
> -		if (!region)
> -			return -EINVAL;
> +	rcu_read_lock();
> +	region = dmemcg_get_region_by_name(region_name);
> +	rcu_read_unlock();
> +	if (!region)
> +		return -EINVAL;
>  
> -		err = dmemcg_parse_limit(options, &new_limit);
> -		if (err < 0)
> -			goto out_put;
> +	err = dmemcg_parse_limit(buf, &new_limit);
> +	if (err < 0)
> +		goto out_put;
>  
> -		pool = get_cg_pool_unlocked(dmemcs, region);
> -		if (IS_ERR(pool)) {
> -			err = PTR_ERR(pool);
> -			goto out_put;
> -		}
> +	pool = get_cg_pool_unlocked(dmemcs, region);
> +	if (IS_ERR(pool)) {
> +		err = PTR_ERR(pool);
> +		goto out_put;
> +	}
>  
> -		/* And commit */
> -		apply(pool, new_limit);
> -		dmemcg_pool_put(pool);
> +	apply(pool, new_limit);
> +	dmemcg_pool_put(pool);
>  
>  out_put:
> -		kref_put(&region->ref, dmemcg_free_region);
> -	}
> -
> +	kref_put(&region->ref, dmemcg_free_region);
>  
>  	return err ?: nbytes;
>  }
> 
> ---
> base-commit: 640c57d6ca1346a1c2363a3f473b405af979e046
> change-id: 20260605-cgroup-dmem-write-single-region-9bf05b6d995d
> 
> Best regards,
> -- 
> Eric Chanudet <echanude@redhat.com>
> 
