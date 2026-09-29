Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA98CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51AF10F071;
	Tue, 29 Sep 2026 19:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zixi5faG";
	dkim-atps=neutral
Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com
 [74.125.231.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A2C310F071
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 19:19:25 +0000 (UTC)
Received: by mail-oi2-f13.google.com with SMTP id
 5614622812f47-4c2c08ff3f8so2206786b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 12:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790709563; cv=none;
 d=google.com; s=arc-20260327;
 b=msX420/0BuEiEvKz+6eJCJpfGg+Ssm2Hok/xMbzs+aZrW0q0KO8JoIummQX1klCzkm
 iJ1A+DT+2Oi9Lu+Vpi4oFTsSpX1fxzkZdRIM6tXnSg8h1ZeToOvxSnwBLMsMT1WucGLJ
 8PV+bAFPyfSbFhV8qJZGIK55BKd8TbShOD8+BiP5/1+NEtBlw6LUCfoBZSSnIpN1zrMW
 tumwUY+flzDPnw5JgfN0GVPcAScSDAnZme6z3PSHyf398pjsxdjEn+cfiwa6ppZggo8F
 V77Z+OG3nl75Sd1iWWQFVrn1EQs3eJWWUUcvuvfB4wn3cQkaGvwCIm+rggGD2EJWNA7X
 OuFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kzJgW1rsJZfo72Y77K+E8QsTkrVDWI4mp7BQj3TrqUo=;
 fh=M5VJzloEnWhh0sHINKvRJLxlvkSzgDuyoK1BzHO7OUg=;
 b=srpYnp8l0R2RJDBkmqAJoXPoGkQuT55BKBzfb+0NfCxwLEu0KR92ZZgMVLJ1yIHT78
 AoLya47lFIiO3aDgsLyPSOlehTG2wGEkVmJJ1qR0za8MHSiQfVGLMaq4nzfXzpUp+8Am
 W4MrnJcKaPip8Ar6Lfy4HXa1xgg/n2QoUKclPk22hUj24jKIPWFwlQSn2fzbBNaG/hSw
 jmxlvrIXxJPRFzoqA1xg5ye2ZKdxq18CavizGPOlLyM1hD40dL9wsVDQe1XoO8HGF8Cj
 PeYeIy1fPxnMAO7TY2nfCGGxA808Trd1sJuBajPsCXtjRToc2Q7yRCoyk76yoql+XmIS
 TM2Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790709563; x=1791314363; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kzJgW1rsJZfo72Y77K+E8QsTkrVDWI4mp7BQj3TrqUo=;
 b=Zixi5faGCARIr10YoSmACtnAogM/1h/AJXrYd4DxpF7AuAwX3M6GoU4arms/5bBgbL
 coZY7lGrmGJAIdDTHRKsKM/gWdc2HVQD7XT9YTvXtFloy+L5sG5UJfVgqNDn6dkSwQ2O
 rgLIHK5ihUBqYQ4yStiqjkN1LCNCvHqRwAcM7+qDE2ic4vuAxoEJYtrq+xwhpZEBvOcM
 aUbXW+VlU8ziwQI1uoCPUuvhNVq1vvgkM+Awl0AuDj3HzntHyIWgds4tZcPiVg5AGrIH
 OTTDFagYBVV1da0JD2lfM3evzlBsCjSz0KkDavSOO40AT7JHCh//OPBOi3fNfZAnvCpD
 JnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790709563; x=1791314363;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kzJgW1rsJZfo72Y77K+E8QsTkrVDWI4mp7BQj3TrqUo=;
 b=docJdWFg0z7D+Nfm8xfWwYhMvHJVINWBD7efHAzRuA9MJ2rkvQlScM/qjTInPaV3fF
 1y89L2J73MMAupzhualmk9nxZlywZjR+xpv8+I68C5EJYW4Q+1WZ1/3p+vmjNLORAUzO
 Bo6+YoZK8CtId2kjRy+ZANxs77whmYeBXOUELPS5YqN+XmsR3N903/dDPdr7n12yWidQ
 M1pvUcd0os7sMx9JEBQwAx7Nlm8+FOps5bCrCG8q4F3f4PQ97vsJ3SNuWauEPIDxLMi6
 z6+mIVBlWunVMVZJwmFwi/pAWu8VmbjwNFY/DskjY1jW2J+j3ML9Wmei322Pk8HP9cSG
 z/LQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiYjL2PEemkv4Ip/vpg/F+jZJ93ORTTst4GxQhiulhyI9FGSvZoMdgW95UeFSzdg+2cDi0lS4yX4U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lJHH5lj0UeqG2pvi8nHQ+8zwmRs5NAmJwl5/saWt5K9HaBeG9M
 NzrhFbdX2TqzLWaTQkbFEPImeombg8Kb0o9GAN3nZmfrK9ZTnWxJpXrnMlqvBU/532CyiXiWY5w
 kWxBwyBmRG+2CQkJiXWyKCsR6hdPKGmk=
X-Gm-Gg: AYBFou0Eb7XY603VFzY2LZubas3xPxOXAffqHuiL+/JCZEqG9YVpzSju0DlAKcfbzrE
 LjSpaZcS65SesfQXVOmWuO9orLnIPlatvxfXz3++hM08qosJ190ED9fSBMSosCiuLakBl2j/Y76
 xSTO+f8yI+vp0uZt6KvMe0Q2t42PtY3Va9qt9nyibP8Zml3taBJd6bpCGjEwIxnscTQCe8mDuUp
 spckqMyJEG32eNvWFmH2BrM17nnu1FWD0VtDZnOyaVmlKjvgZYbtEK8eG+3dLAblc4sjs+k0Mnj
 U8Ig7wpPlyhcYwxUJAI/UEpgII0DkyrbUOfduUR3HdHewBWSqjyNm7enPTX3WqgnTYIPtOg/X4I
 zCoaTcdsqFA==
X-Received: by 2002:a05:6808:1714:b0:4c3:82cd:601a with SMTP id
 5614622812f47-4f06a4671d5mr577481b6e.32.1790709563185; Tue, 29 Sep 2026
 12:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260926174406.346253-1-devnexen@gmail.com>
 <e5b5770f-8ae1-41c3-b5d9-53798dd3fd45@amd.com>
In-Reply-To: <e5b5770f-8ae1-41c3-b5d9-53798dd3fd45@amd.com>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 29 Sep 2026 20:19:12 +0100
X-Gm-Features: AclHuK-hjcBmIezQ0GYgI88OqlUbULC7G7Y8Vcu-Rocor7p5PAhT4RVRzBr4btA
Message-ID: <CA+XhMqzQRS4Re6YXONFmrt2rOOKoghyQqFgHu=Ziixpm2n4sLA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Fix NPA-REVOKE racing an in-flight UALink
 import
To: Mukul Joshi <mukul.joshi@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Mukul,

On Tue, 29 Sept 2026 at 20:05, Mukul Joshi <mukul.joshi@amd.com> wrote:
>
> Hi David,
>
> Thanks for the patch. Yes the race is real, however, the patch needs some updations.
>
> More below.
>
>
> On 9/26/2026 1:44 PM, David Carlier wrote:
>
> [You don't often get email from devnexen@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> The exporter records an importer when it answers NPA-REQ, so it can send
> NPA-REVOKE as soon as the BO is freed, before the importer has finished
> building the dma-buf for that handle. The revoke handler assumes a fully
> imported node: it dereferences imp_xa_node->dmabuf, which is still NULL
> until the import completes, and drops the xarray reference the importing
> thread still relies on. The importer then links the node and marks it
> READY regardless, so the node can be freed while still on the per-remote
> list.
>
> Only tear down a node that is READY. Otherwise mark it for teardown and
> send NPA-RELEASE, as nothing has been handed to user-space yet, and wake
> the importer if it is still waiting for NPA-RSP so that it fails right
> away. A node already in teardown belongs to whoever moved it there, so a
> duplicate NPA-REVOKE no longer touches it either. The importer checks for
> teardown under the xarray lock before linking the node and marking it
> READY, and unwinds otherwise.
>
> I think NPA-REVOKE cannot land before a NPA-RSP so we will not hit the condition where
> we have to wake up the importer.
> NPA-REVOKE is sent only when the exporter's XA entry's ref count goes down to 0.
> That will happen at the end of process_npa_req(), by that time, the NPA-RSP is already sent.
>
> Fixes: 7cc82cd90d35 ("drm/amdgpu: Implement mechanism to revoke exported memory")
> Assisted-by: LLM
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> Changes in v2:
> - Tear down only READY nodes, so a duplicate NPA-REVOKE for a node already
>   in teardown neither dereferences a NULL dmabuf nor drops the node
>   reference twice (Sashiko).
> - Complete npa_done when a revoke arrives before NPA-RSP, so the importer
>   fails right away instead of timing out into a connection reset (Sashiko).
> - Use the current Assisted-by format.
>
> Found by code analysis and compile-tested with W=1. Not tested on hardware,
> as it needs two UALink-connected accelerators in a vPod.
>
> v1: https://lore.kernel.org/all/20260926171625.288519-1-devnexen@gmail.com/
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 34 +++++++++++++++++++---
>  1 file changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 8411ea17172f..cb35026e6eba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -3265,6 +3265,7 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
>  {
>         struct amdgpu_ualink_imp_xa_node *imp_xa_node;
>         struct amdgpu_bo *bo;
> +       u32 node_state;
>         int r = 0;
>
>         /* Remove the entry from the Xarray. */
> @@ -3288,7 +3289,23 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
>                 return;
>         }
>
> +       node_state = READ_ONCE(imp_xa_node->node_state);
>         WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
> +
> +       /* Only a READY node is torn down here. If the import is still in
> +        * flight, the dmabuf may not exist yet and nothing has been handed
> +        * to user-space: leave the node to the importing thread, which sees
> +        * the teardown state and unwinds, and wake it up if it is still
> +        * waiting for NPA-RSP. A node already in teardown is owned by
> +        * whoever moved it there, e.g. an earlier NPA-REVOKE.
> +        */
> +       if (node_state != AMDGPU_UALINK_NODE_READY) {
> +               if (node_state == AMDGPU_UALINK_NODE_NOT_READY)
> +                       complete(&imp_xa_node->npa_done);
> +               xa_unlock(&adev->ualink.imp_xa);
> +               goto send_release;
> +       }
>
> As mentioned above, NPA-REVOKE cannot land before the NPA-RSP is sent by the exporter.
> So, if the node_state is NOT_READY that means its a stale NPA_REVOKE and we should just ignore
> that NPA-REVOKE. Having said that, we should definitely do the teardown when the node_state is READY.
> We should also handle NPA-REVOKE while node_state is in PENDING state.
> So, maybe we can refactor this code to something like this:
>
> switch (READ_ONCE(imp_xa_node->node_state)) {
>     case AMDGPU_UALINK_NODE_READY:
>         /* existing teardown */
>         break;
>     case AMDGPU_UALINK_NODE_PENDING:
>         WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_TEARDOWN);
>         xa_unlock(&adev->ualink.imp_xa);
>         break;
>     default:
>         xa_unlock(&adev->ualink.imp_xa);
>         return;
>     }
>
> +
>         list_del_init(&imp_xa_node->list);
>         xa_unlock(&adev->ualink.imp_xa);
>
> @@ -3299,6 +3316,7 @@ static void amdgpu_ualink_process_npa_revoke_msg(struct amdgpu_device *adev,
>         /* Drop the refcount for the node */
>         amdgpu_ualink_imp_xa_entry_put(imp_xa_node);
>
> +send_release:
>         r = amdgpu_ualink_send_npa_release_msg(adev, remote_acc_id, handle);
>         if (r)
>                 dev_err(adev->dev,
> @@ -3760,9 +3778,20 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
>                 return r;
>         }
>
> -       /* Add this node to the imported handles list for the remote GPU */
> +       /* Add this node to the imported handles list for the remote GPU,
> +        * unless the exporter revoked the handle while the import was in
> +        * flight. The dmabuf is released with the last node reference.
> +        */
>         xa_lock(&adev->ualink.imp_xa);
> +       if (READ_ONCE(imp_xa_node->node_state) == AMDGPU_UALINK_NODE_TEARDOWN) {
> +               xa_unlock(&adev->ualink.imp_xa);
> +               dev_warn(adev->dev,
> +                        "IMPORT: handle:%llx:%llx revoked during import\n",
> +                        handle.handle_hi, handle.handle_lo);
> +               return -EINVAL;
> +       }
>         list_add(&imp_xa_node->list, &adev->ualink.imp_handles_list[remote_acc_id]);
> +       WRITE_ONCE(imp_xa_node->node_state, AMDGPU_UALINK_NODE_READY);
>         xa_unlock(&adev->ualink.imp_xa);
>
> The changes here makes sense. One nit-pick is to change from dev_warn to dev_dbg().
>
>         return 0;
> @@ -3938,9 +3967,6 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
>                                         "IMPORT: XA import failed for handle:%llx:%llx\n",
>                                         handle.handle_hi, handle.handle_lo);
>                         goto cleanup;
> -               } else {
> -                       WRITE_ONCE(imp_xa_node->node_state,
> -                                  AMDGPU_UALINK_NODE_READY);
>                 }
>
> ACK.
>
>
> Regards,
>
> Mukul
>
>         }
>
> --
> 2.55.0

True, a revoke can't arrive before NPA-RSP, so
v3 uses your switch and dev_dbg():

Cheers.
