Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CA606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=oDF3vE9W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75A511250B;
	Thu, 26 Nov 2026 15:43:01 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B43F10E942;
 Thu, 26 Nov 2026 15:42:54 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AQ7ZPP5382945; Thu, 26 Nov 2026 15:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=o
 zPNEce7sUqPbIrlPxruhn05mHpz54QnqYsdshoSnsk=; b=oDF3vE9W1dlRDkth5
 c0rPGFTaC1DbK21raMHCluoP+xymHLNpD+iH1VHYMbSdyhUOA79DnjmPISy3cc/q
 ZzS2x+UETJk4tDqHToUyUgTJK8dXJMaYGF91Nlh9r7lzDcSRGMekTG8Des1bxYSr
 35J9XIEov3nNTlgPIRIjDWsmn6321MhTDiOHPJpShEoikMTRlNkQkkeKVlz0ASbr
 WZo6ZFNChY87TGUXNPzXAVF1PFo8P0REeBneOTE8PBOI/N6meGsS4ya+Ta5vrV0z
 N+T+WAm+ZVe2QQGp4Kxpj6/j8UqeyhNSClLq9J32h/1e88KnlxlrAqxVMaIK4JOk
 KVirQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4j3491mf1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Thu, 26 Nov 2026 15:42:45 +0000 (GMT)
Received: from np-a-belle.kl.imgtec.org (172.25.6.177) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 15:42:44 +0000
Message-ID: <1463fe4976d02b8b6d748dbb560a88bf54525cf1.camel@imgtec.com>
Subject: Re: [PATCH v2 2/2] drm/imagination: Stop locking reservations
 around map and unmap
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
To: Gyeyoung Baek <gye976@gmail.com>, Alessio Belle <alessio.belle@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Alexandru Dadu <alexandru.dadu@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Date: Thu, 26 Nov 2026 15:42:44 +0000
In-Reply-To: <20261011-pvr-gpuvm-immediate-v2-2-744ddc6644c3@gmail.com>
References: <20261011-pvr-gpuvm-immediate-v2-0-744ddc6644c3@gmail.com>
 <20261011-pvr-gpuvm-immediate-v2-2-744ddc6644c3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA2MSBTYWx0ZWRfXzunwspnQv0I4
 YnnFmhj81qFe/1c6MbBDfgqBvzhtuDPYh6CRaUjTWatTUy4bpsQ2EHup+TeealeHUBiS6IJ8rnC
 Zvn/G8RewaGJBRtvTAaxD++EMgDx7Pt8zg+6qQjuFnRKQWsOdP2O83ACSt7jqjhAW2Q49ap88Gi
 dfF/F8U1hzwojwCQn6HmFKbCyTNtL+33WyPQjh39rScUN4VtTt8eKnZwNxYo7FGmMkibeVX82Pv
 jsOfgnXbbH1BpnQ5tsLoYA2sdnCGg4nLWtCsc+GFZEZK3iBv66rEsgXXieW6m3P0RnM4XAdzGgh
 Ocay6XUyqGULYsvK/JExcEAnk55tQ9YPGfsd5SSc1cuhkSo1sTOigGUixo09nj9vaD2ppQUktJj
 i2u/VYiCipa4tI5JPrDw3Zhws5HtzTuftI+zYvcHun2/gGzso04uoyfwL7wFf6LNpDUnKzR/E7p
 aVgdn3TR1zBIy2cgZEg==
X-Authority-Analysis: v=2.4 cv=OaENnRTY c=1 sm=1 tr=0 ts=6b085375 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=2JH569OHYJkA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=pGLkceISAAAA:8 a=r_1tXGB3AAAA:8 a=yx_059eXjXyrX1SpRQ8A:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA2MSBTYWx0ZWRfX4+dSJTb/GfeT
 w62AR1/lSe0ZP9YltNzfzN65lMO2CRTJS1scVt9uw8ynsLq78LeiJqgxlSuGM6BPLVflOpPEdJr
 v6xY9vtky1raJiLe5StBcL4DWdylcro=
X-Proofpoint-GUID: MuAbyYGpcubLUdFAdJMS0DByehffB0pJ
X-Proofpoint-ORIG-GUID: MuAbyYGpcubLUdFAdJMS0DByehffB0pJ
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Gyeyoung,

this patch (and the previous) was tested with a CTS cycle and results showe=
d no
regressions.

On Sun, 2026-10-11 at 18:45 +0900, Gyeyoung Baek wrote:
> The GPUVA lists are now protected by gpuva.lock instead of the
> reservations, so map and unmap no longer need to lock the reservations.
> Nothing else on that path relies on them.
>=20
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---

Reviewed-by: Luigi Santivetti <luigi.santivetti@imgtec.com>

>  drivers/gpu/drm/imagination/pvr_vm.c | 43 ------------------------------=
------
>  1 file changed, 43 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagi=
nation/pvr_vm.c
> index 807a01aab1d..08ce6542550 100644
> --- a/drivers/gpu/drm/imagination/pvr_vm.c
> +++ b/drivers/gpu/drm/imagination/pvr_vm.c
> @@ -704,16 +704,6 @@ void pvr_destroy_vm_contexts_for_file(struct pvr_fil=
e *pvr_file)
>  	}
>  }
> =20
> -static int
> -pvr_vm_lock_extra(struct drm_gpuvm_exec *vm_exec)
> -{
> -	struct pvr_vm_bind_op *bind_op =3D vm_exec->extra.priv;
> -	struct pvr_gem_object *pvr_obj =3D bind_op->pvr_obj;
> -
> -	/* Acquire lock on the GEM object being mapped/unmapped. */
> -	return drm_exec_lock_obj(&vm_exec->exec, gem_from_pvr_gem(pvr_obj));
> -}
> -
>  /**
>   * pvr_vm_map() - Map a section of physical memory into a section of
>   * device-virtual memory.
> @@ -741,15 +731,6 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr=
_gem_object *pvr_obj,
>  	   u64 pvr_obj_offset, u64 device_addr, u64 size)
>  {
>  	struct pvr_vm_bind_op bind_op =3D {0};
> -	struct drm_gpuvm_exec vm_exec =3D {
> -		.vm =3D &vm_ctx->gpuvm_mgr,
> -		.flags =3D DRM_EXEC_INTERRUPTIBLE_WAIT |
> -			 DRM_EXEC_IGNORE_DUPLICATES,
> -		.extra =3D {
> -			.fn =3D pvr_vm_lock_extra,
> -			.priv =3D &bind_op,
> -		},
> -	};
> =20
>  	int err =3D pvr_vm_bind_op_map_init(&bind_op, vm_ctx, pvr_obj,
>  					  pvr_obj_offset, device_addr,
> @@ -761,15 +742,7 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr=
_gem_object *pvr_obj,
>  	pvr_gem_object_get(pvr_obj);
> =20
>  	mutex_lock(&vm_ctx->lock);
> -	err =3D drm_gpuvm_exec_lock(&vm_exec);
> -	if (err)
> -		goto err_cleanup;
> -
>  	err =3D pvr_vm_bind_op_exec(&bind_op);
> -
> -	drm_gpuvm_exec_unlock(&vm_exec);
> -
> -err_cleanup:
>  	mutex_unlock(&vm_ctx->lock);
> =20
>  	pvr_vm_bind_op_fini(&bind_op);
> @@ -802,15 +775,6 @@ pvr_vm_unmap_obj_locked(struct pvr_vm_context *vm_ct=
x,
>  			u64 device_addr, u64 size)
>  {
>  	struct pvr_vm_bind_op bind_op =3D {0};
> -	struct drm_gpuvm_exec vm_exec =3D {
> -		.vm =3D &vm_ctx->gpuvm_mgr,
> -		.flags =3D DRM_EXEC_INTERRUPTIBLE_WAIT |
> -			 DRM_EXEC_IGNORE_DUPLICATES,
> -		.extra =3D {
> -			.fn =3D pvr_vm_lock_extra,
> -			.priv =3D &bind_op,
> -		},
> -	};
> =20
>  	int err =3D pvr_vm_bind_op_unmap_init(&bind_op, vm_ctx, pvr_obj,
>  					    device_addr, size);
> @@ -819,15 +783,8 @@ pvr_vm_unmap_obj_locked(struct pvr_vm_context *vm_ct=
x,
> =20
>  	pvr_gem_object_get(pvr_obj);
> =20
> -	err =3D drm_gpuvm_exec_lock(&vm_exec);
> -	if (err)
> -		goto err_cleanup;
> -
>  	err =3D pvr_vm_bind_op_exec(&bind_op);
> =20
> -	drm_gpuvm_exec_unlock(&vm_exec);
> -
> -err_cleanup:
>  	pvr_vm_bind_op_fini(&bind_op);
> =20
>  	return err;
>=20

