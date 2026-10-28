Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3055606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.a=rsa-sha256 header.s=ovhmo-selector-1 header.b=ruqqm7HB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 337BF10E628;
	Wed, 28 Oct 2026 11:34:04 +0000 (UTC)
Received: from smtpout4.mo537.mail-out.ovh.net
 (smtpout4.mo537.mail-out.ovh.net [51.210.91.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19DEA10FB96
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 11:33:55 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4jF4xs2dxWz3xXY;
 Wed, 28 Oct 2026 11:33:53 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <matthew.brost@intel.com>; Wed, 28 Oct 2026 11:33:53 +0000 (UTC)
Received: from mta11.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.0.227])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jF4xs0lNsz6MYZ; Wed, 28 Oct 2026 11:33:53 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.11])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta11.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id A88A39A201C;
 Wed, 28 Oct 2026 11:33:52 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S0037c77449a-a366-4f22-8434-8269668623ce,
 B9A4BA19920B1A547E88FAC628035BC292DACFB8) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
Message-ID: <21c4abe0-7923-436f-b35c-6e07e6342930@pixelcluster.dev>
Date: Wed, 28 Oct 2026 12:33:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] drm/ttm: Allow skipping to the next priority in
 the bo LRU cursor
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20261027224902.1085762-1-matthew.brost@intel.com>
 <20261027224902.1085762-3-matthew.brost@intel.com>
Content-Language: en-US
From: Natalie Vock <nat@pixelcluster.dev>
In-Reply-To: <20261027224902.1085762-3-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 15970045755831836951
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFvmHWQLI/a0+1Q33ENsSOCSdTifS2BS5dr+wAgamoCs+MZkG1mIG9IilDR9PoAufU6x9pZuiS/EmHe031Q7gpogZehYFQWpiEmgemd9ZwhUt593ezcGLgKOpnamkE9HwbeaMQ6BAjdw+F5Ja0YlkKvIJsTMmu0RfsdRg2rh9bREvwftmESOJBKIPe0vBIlnIDFmKYP4WIjwLiYGhuqoz8kU3Pnfp4C3bF5GptQZfOtaH7kEGoj56WUA0wzXbZC9ygSj7mGWmsR2KVl9VnzdK4BsBM1z+qUBbKQTFMDjDxub6Kv6mtpOMxhvZnY5VJLvqHnDCWkkJlxCpon56tMox1OTn56r3BEczJNPQ6vjw8POMkhEEp2GRrnV3uh8l+sobI297iBjrtbmQRlI1352YJxPiRLJcF1/tYtVhiXOidEp/iv+h0+DCss7EqOthTqQjgP5IQdEj4Ao9w5ynymyLeO2ZQtmmzhCrxxmHXCXVbj/jiY5iocxvItEMuTaCRGF86rZVtnuD3p+Hp/pT000u6wHYndchqDmbea0hh1xnNt1NOljEsjviLXhWBLtmegfT0fxkobFbyRk0Z4LnMSkjyp/8Zf+jURH6dEaBNxMvm7wsFeJizuAbdRy0O4vKQVDKL7GKtLrunWH9RueX0FdIC8SzmtLOik+jLHGMIhnDu8mw
DKIM-Signature: a=rsa-sha256; bh=merD/MdN8l9vGYzfaFTNnIyTj4TKd7HKHyFWXG/an8s=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1793187233; v=1;
 b=ruqqm7HBy+wwSsL5EI4Xgr3Lcj9yOG3xoqQRZq7C1bF9vOFeJnlxpHMrHrZKkY5JELzLhnFo
 vJNlLGyjkeMbMpW+EZ4KJPF6xCGPDDyvCiGsvwBpsXYzhyRS4E7cCnnbX3+eP/a+2pnY3BtrXiv
 HjKcvPn5ZTWtsJiH5n6/5kJ6wzNTUUzwvpd1WJpFHfLnUZzQM31DK/8mc8p0sl+HS9/EED0DnAv
 DxCkU3eUghGDu3AUdiPYg8zlKMtAJuJB4+MQ30eGks0E4HlvnlEqokLFw+xAD7bdyf+dG9Oy7AN
 phacMF2k6nhe6xdCc1x60h3OPibZjj5S0Rd9ydI52er+g==
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 10/27/26 23:49, Matthew Brost wrote:
> Drivers walking a manager's LRU with ttm_bo_lru_for_each_reserved_guarded()
> may decide that the rest of the current priority isn't worth walking,
> for example when the priority is roughly age ordered and the walk hit
> a BO that is still too hot to evict. Today the only option is to stop
> the walk altogether, which also gives up on the remaining priorities.
> 
> Add ttm_resource_manager_next_priority() to move a resource cursor to
> the start of the next priority, and ttm_bo_lru_cursor_skip_priority()
> to make the next ttm_bo_lru_cursor_next() use it.
> 
> While at it, stop incrementing the cursor priority past the last valid
> priority once the iteration is done.
> 
> Assisted-by: LLM
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
>  drivers/gpu/drm/ttm/ttm_bo_util.c  |  3 +++
>  drivers/gpu/drm/ttm/ttm_resource.c | 35 ++++++++++++++++++++++++++----
>  include/drm/ttm/ttm_bo.h           | 19 ++++++++++++++++
>  include/drm/ttm/ttm_resource.h     |  2 ++
>  4 files changed, 55 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index f9458a4d5a09..d626f014e61f 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -997,6 +997,9 @@ __ttm_bo_lru_cursor_next(struct ttm_bo_lru_cursor *curs)
>  		if (first) {
>  			res = ttm_resource_manager_first(&curs->res_curs);
>  			first = false;
> +		} else if (curs->skip_priority) {
> +			res = ttm_resource_manager_next_priority(&curs->res_curs);
> +			curs->skip_priority = false;
>  		} else {
>  			res = ttm_resource_manager_next(&curs->res_curs);
>  		}
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index 4e6d3d658d85..e631507d7aa1 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -674,6 +674,17 @@ ttm_resource_cursor_check_bulk(struct ttm_resource_cursor *cursor,
>  	}
>  }
>  
> +static bool ttm_resource_cursor_next_priority(struct ttm_resource_cursor *cursor)
> +{
> +	if (cursor->priority + 1 >= TTM_MAX_BO_PRIORITY)
> +		return false;
> +
> +	list_move(&cursor->hitch.link, &cursor->man->lru[++cursor->priority]);
> +	ttm_resource_cursor_clear_bulk(cursor);
> +
> +	return true;
> +}
> +
>  /**
>   * ttm_resource_manager_first() - Start iterating over the resources
>   * of a resource manager
> @@ -723,16 +734,32 @@ ttm_resource_manager_next(struct ttm_resource_cursor *cursor)
>  			}
>  		}
>  
> -		if (++cursor->priority >= TTM_MAX_BO_PRIORITY)
> +		if (!ttm_resource_cursor_next_priority(cursor))
>  			break;
> -
> -		list_move(&cursor->hitch.link, &man->lru[cursor->priority]);
> -		ttm_resource_cursor_clear_bulk(cursor);
>  	}
>  
>  	return NULL;
>  }
>  
> +/**
> + * ttm_resource_manager_next_priority() - Skip the rest of the current
> + * priority and continue iterating at the next one
> + * @cursor: cursor to record the position
> + *
> + * Return: the first resource of the next non-empty priority, or NULL if
> + * there is none.
> + */
> +struct ttm_resource *
> +ttm_resource_manager_next_priority(struct ttm_resource_cursor *cursor)
> +{
> +	lockdep_assert_held(&cursor->man->bdev->lru_lock);
> +
> +	if (!ttm_resource_cursor_next_priority(cursor))
> +		return NULL;
> +
> +	return ttm_resource_manager_next(cursor);
> +}
> +
>  /**
>   * ttm_lru_first_res_or_null() - Return the first resource on an lru list
>   * @head: The list head of the lru list.
> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> index 32791c4db2a9..2fc517dbf03d 100644
> --- a/include/drm/ttm/ttm_bo.h
> +++ b/include/drm/ttm/ttm_bo.h
> @@ -507,10 +507,29 @@ struct ttm_bo_lru_cursor {
>  	 * unlock before the next iteration or after loop exit.
>  	 */
>  	bool needs_unlock;
> +	/**
> +	 * @skip_priority: Continue at the next LRU priority on the next
> +	 * iteration. See ttm_bo_lru_cursor_skip_priority().
> +	 */
> +	bool skip_priority;
>  	/** @arg: Pointer to common BO LRU walk arguments. */
>  	struct ttm_lru_walk_arg *arg;
>  };
>  
> +/**
> + * ttm_bo_lru_cursor_skip_priority() - Skip the rest of the current priority
> + * @curs: The cursor.
> + *
> + * Make the next ttm_bo_lru_cursor_next() skip the remaining buffer objects
> + * of the current LRU priority and continue at the next priority, for
> + * example when the caller decides the rest of the priority isn't worth
> + * walking.
> + */
> +static inline void ttm_bo_lru_cursor_skip_priority(struct ttm_bo_lru_cursor *curs)
> +{
> +	curs->skip_priority = true;

Hm. I wonder if you could instead call ttm_bo_lru_cursor_cleanup_bo() here and
then increment the priority (with proper checks). Then the normal LRU iteration
should also select the first item on the proper priority's LRU.

It sort of conflicts the other refactoring you did, but doing things this way
avoids adding more boolean flags and complexity in __ttm_bo_lru_cursor_next
(which I'm not a huge fan of).

Best,
Natalie

> +}
> +
>  void ttm_bo_lru_cursor_fini(struct ttm_bo_lru_cursor *curs);
>  
>  struct ttm_bo_lru_cursor *
> diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
> index 714c533622c2..8cd70d1e5481 100644
> --- a/include/drm/ttm/ttm_resource.h
> +++ b/include/drm/ttm/ttm_resource.h
> @@ -499,6 +499,8 @@ struct ttm_resource *
>  ttm_resource_manager_first(struct ttm_resource_cursor *cursor);
>  struct ttm_resource *
>  ttm_resource_manager_next(struct ttm_resource_cursor *cursor);
> +struct ttm_resource *
> +ttm_resource_manager_next_priority(struct ttm_resource_cursor *cursor);
>  
>  struct ttm_resource *
>  ttm_lru_first_res_or_null(struct list_head *head);

