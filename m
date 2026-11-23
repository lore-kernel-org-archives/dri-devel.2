Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A7606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=damsy.net header.i=@damsy.net header.a=ed25519-sha256 header.s=v1-ed25519-20261120 header.b=Qkw2N36y;
	dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.a=rsa-sha256 header.s=v1-rsa-20261120 header.b=Thrv63xZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9894910EE5C;
	Mon, 23 Nov 2026 14:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="Qkw2N36y";
	dkim=temperror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="Thrv63xZ";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C918510EE5C;
 Mon, 23 Nov 2026 14:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20261120; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1795443824; bh=Jb7lWSdA/FOvxoGpQUYVAsP
 E2P8oHPnQGeJ8TzBswS0=; b=Qkw2N36yfKv7exqjMPPXCGm3LxYbRVetoqgVP70AjrJ60mzSzW
 wY44ohBZPJJ6ktnI6Iyco//GeVuLqEfgIYBQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20261120; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1795443824; bh=Jb7lWSdA/FOvxoGpQUYVAsP
 E2P8oHPnQGeJ8TzBswS0=; b=Thrv63xZtLBWVUooaRPAl8YRQDzfkdabIl/JXajZiTYhFjM/BW
 x9178xHEueVdhweYrHYAq0YFjW7BXbSFHMbsV/SONWShX+11hRDoxDRcFFLUZW/Kdv4fc+wGn5k
 cXqFFWB4U6YHna7i5Niq/c247yB3hFPEiAqiP8iw64AhSpo+78O3XXuBcPZRdrHACZh8hnNb2v4
 Kl+d0/1WKaLtQHL+jM9HTrX/T3laPUy/bF2otj8sF1vFz6f3N8QTtqFwgQLWqvhhJ2jfYNDCEL2
 vhnYRNdiVcQWKET0Ym4MuOBMAehkXFDn1bp1W4oklNNt7WGrdpKyhpXGKrmCyaZH4wQ==;
Message-Instance: m=1; h=sha256:CbnZATPqXVVlsT1Fi2UUSaZAXHiT5QED/YMAGZaC
 sWs=:feajcthX+9ujN7/lqiDFASl385l/1K3ZGNeesPEE87o=;
DKIM2-Signature: i=1; m=1; t=1795443824; d=damsy.net; mf=PHBpZXJyZS1lcmlj
 QGRhbXN5Lm5ldD4=; rt=PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+,PGNocmlzdGlhbi5r
 b2VuaWdAYW1kLmNvbT4=,PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+,PHBpZXJyZS1lcmljLnBl
 bGxvdXgtcHJheWVyQGFtZC5jb20+,PHNpbW9uYUBmZndsbC5jaD4=,PGFpcmxpZWRAZ21haWwu
 Y29tPg==,PHNhc2hpa28tYm90QGtlcm5lbC5vcmc+,PGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
 b3Aub3JnPg==,PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+,PGxpbnV4LWtlcm5l
 bEB2Z2VyLmtlcm5lbC5vcmc+; s=v2-mldsa44-20261103:mldsa44:k4/bdU9X9jHWmx1m
 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|v2-ed25519-20261120:
 ed25519-sha256:CTVKiaR1Yt1Mn9Yultkd1MIPIgQAaRHO6CMKyluErekys3ymK4yJnjuUR2tZ
 GzJCxds6KQMibi9IDKH55fyTBQ==|v2-rsa-20261120:rsa-sha256:krf7UbLk9V1csOfo
 2L6OqouYbWcvu/otMK1Mb5QlDIBJP6sSC9IrBjvWhPlgNsAMpGvY0ES+nxnullC6+HRdLpmB
 4LmxN22lbkpoENYxsLjeSzMOWx7tOkmIEvDlYgMF2rqGaXZyn+35MV8CPo4H1Iz1FZKMWFGx
 EuUT/OvRMNvkLdfxtxczN6UVArazdW+H8fULDbSDjmGvW7wAiR9KJlQheGSPxYRhSglLl9Ac
 jCUTVoO8Tize4Qhyk1YaZvFEyED3Lf0ay8M2/k+CUYASIM3rI7vt+bsuZ1ijn16wlM9vtx0B
 CGOJXrP8VMcEXsOLAfey07Xgn4bFQ9qz+dy4UQ==;
Message-ID: <367d0247-8523-42bb-9c8c-5194f0c9fe95@damsy.net>
Date: Mon, 23 Nov 2026 15:23:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] drm/amdkfd: avoid NULL kfd_process_device in
 kfd_profiler_pmc
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sashiko-bot <sashiko-bot@kernel.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: fr
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ping ?

Le 09/11/2026 à 18:13, Pierre-Eric Pelloux-Prayer a écrit :
> All other callers of kfd_process_device_data_by_id deal with
> a possible NULL return value except kfd_profiler_pmc.
> 
> Check it after the mutex unlock and return -EINVAL as others
> place do.
> 
> Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com?part=4
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 6c710e4a5220..ad086240a6dd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3463,8 +3463,10 @@ static inline int kfd_profiler_pmc(struct kfd_process *p,
>   	/* Enable/disable perfcount if requested */
>   	mutex_lock(&p->mutex);
>   	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
> -	dqm = pdd->dev->dqm;
>   	mutex_unlock(&p->mutex);
> +	if (!pdd)
> +		return -EINVAL;
> +	dqm = pdd->dev->dqm;
>   
>   	dqm->ops.set_perfcount(dqm, args->perfcount_enable);
>   	return status;

