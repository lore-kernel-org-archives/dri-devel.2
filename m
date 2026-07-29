Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D69C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 04:17:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B55010E81E;
	Wed, 29 Jul 2026 04:17:36 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ABF310E96F
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 04:17:18 +0000 (UTC)
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-1X-tBTSXMvu9J76Kd2OYjA-1; Wed,
 29 Jul 2026 00:17:13 -0400
X-MC-Unique: 1X-tBTSXMvu9J76Kd2OYjA-1
X-Mimecast-MFC-AGG-ID: 1X-tBTSXMvu9J76Kd2OYjA_1785298632
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7489D18004D4; Wed, 29 Jul 2026 04:17:12 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 375C11800480; Wed, 29 Jul 2026 04:17:09 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org,
	dakr@kernel.org
Subject: [PATCH 4/6] nouveau/gsp: refactor the chan allocation arguments into
 a struct
Date: Wed, 29 Jul 2026 14:15:28 +1000
Message-ID: <20260729041653.3985549-5-airlied@gmail.com>
In-Reply-To: <20260729041653.3985549-1-airlied@gmail.com>
References: <20260729041653.3985549-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3KkUriZIqspm9I8S8O9YAfsLNUS7TKOVPb4kYOnCdfQ_1785298632
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
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

From: Dave Airlie <airlied@redhat.com>

this has a lot of args, and it wants to grow more in the future,
lets just refactor this out and make it cleaner.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 .../nouveau/nvkm/subdev/gsp/rm/r535/fifo.c    | 48 +++++++++++--------
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/gr.c  | 18 +++++--
 .../nouveau/nvkm/subdev/gsp/rm/r570/fifo.c    | 31 ++++++------
 .../drm/nouveau/nvkm/subdev/gsp/rm/r570/gr.c  | 18 +++++--
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h   | 17 +++++--
 5 files changed, 83 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c b/drive=
rs/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c
index 76ee938efea3..6603b1951772 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fifo.c
@@ -72,15 +72,14 @@ r535_chan_ramfc_clear(struct nvkm_chan *chan)
 #define CHID_PER_USERD 8
=20
 static int
-r535_chan_alloc(struct nvkm_gsp_device *device, u32 handle, u32 nv2080_eng=
ine_type, u8 runq,
-=09=09bool priv, int chid, u64 inst_addr, u64 userd_addr, u64 mthdbuf_addr=
,
-=09=09struct nvkm_vmm *vmm, u64 gpfifo_offset, u32 gpfifo_length,
+r535_chan_alloc(struct nvkm_gsp_device *device, u32 handle,
+=09=09const struct nvkm_rm_chan_alloc_args *chan_args,
 =09=09struct nvkm_gsp_object *chan)
 {
 =09struct nvkm_gsp *gsp =3D device->object.client->gsp;
 =09struct nvkm_fifo *fifo =3D gsp->subdev.device->fifo;
-=09const int userd_p =3D chid / CHID_PER_USERD;
-=09const int userd_i =3D chid % CHID_PER_USERD;
+=09const int userd_p =3D chan_args->chid / CHID_PER_USERD;
+=09const int userd_i =3D chan_args->chid % CHID_PER_USERD;
 =09NV_CHANNELGPFIFO_ALLOCATION_PARAMETERS *args;
=20
 =09args =3D nvkm_gsp_rm_alloc_get(&device->object, handle,
@@ -88,14 +87,14 @@ r535_chan_alloc(struct nvkm_gsp_device *device, u32 han=
dle, u32 nv2080_engine_ty
 =09if (WARN_ON(IS_ERR(args)))
 =09=09return PTR_ERR(args);
=20
-=09args->gpFifoOffset =3D gpfifo_offset;
-=09args->gpFifoEntries =3D gpfifo_length / 8;
+=09args->gpFifoOffset =3D chan_args->gpfifo_offset;
+=09args->gpFifoEntries =3D chan_args->gpfifo_length / 8;
=20
 =09args->flags  =3D NVDEF(NVOS04, FLAGS, CHANNEL_TYPE, PHYSICAL);
 =09args->flags |=3D NVDEF(NVOS04, FLAGS, VPR, FALSE);
 =09args->flags |=3D NVDEF(NVOS04, FLAGS, CHANNEL_SKIP_MAP_REFCOUNTING, FAL=
SE);
-=09args->flags |=3D NVVAL(NVOS04, FLAGS, GROUP_CHANNEL_RUNQUEUE, runq);
-=09if (!priv)
+=09args->flags |=3D NVVAL(NVOS04, FLAGS, GROUP_CHANNEL_RUNQUEUE, chan_args=
->runq);
+=09if (!chan_args->priv)
 =09=09args->flags |=3D NVDEF(NVOS04, FLAGS, PRIVILEGED_CHANNEL, FALSE);
 =09else
 =09=09args->flags |=3D NVDEF(NVOS04, FLAGS, PRIVILEGED_CHANNEL, TRUE);
@@ -117,30 +116,30 @@ r535_chan_alloc(struct nvkm_gsp_device *device, u32 h=
andle, u32 nv2080_engine_ty
 =09args->flags |=3D NVDEF(NVOS04, FLAGS, MAP_CHANNEL, FALSE);
 =09args->flags |=3D NVDEF(NVOS04, FLAGS, SKIP_CTXBUFFER_ALLOC, FALSE);
=20
-=09args->hVASpace =3D vmm->rm.object.handle;
-=09args->engineType =3D nv2080_engine_type;
+=09args->hVASpace =3D chan_args->vmm->rm.object.handle;
+=09args->engineType =3D chan_args->nv2080_engine_type;
=20
-=09args->instanceMem.base =3D inst_addr;
+=09args->instanceMem.base =3D chan_args->inst_addr;
 =09args->instanceMem.size =3D fifo->func->chan.func->inst->size;
 =09args->instanceMem.addressSpace =3D 2;
 =09args->instanceMem.cacheAttrib =3D 1;
=20
-=09args->userdMem.base =3D userd_addr;
+=09args->userdMem.base =3D chan_args->userd_addr;
 =09args->userdMem.size =3D fifo->func->chan.func->userd->size;
 =09args->userdMem.addressSpace =3D 2;
 =09args->userdMem.cacheAttrib =3D 1;
=20
-=09args->ramfcMem.base =3D inst_addr;
+=09args->ramfcMem.base =3D chan_args->inst_addr;
 =09args->ramfcMem.size =3D 0x200;
 =09args->ramfcMem.addressSpace =3D 2;
 =09args->ramfcMem.cacheAttrib =3D 1;
=20
-=09args->mthdbufMem.base =3D mthdbuf_addr;
+=09args->mthdbufMem.base =3D chan_args->mthdbuf_addr;
 =09args->mthdbufMem.size =3D fifo->rm.mthdbuf_size;
 =09args->mthdbufMem.addressSpace =3D 1;
 =09args->mthdbufMem.cacheAttrib =3D 0;
=20
-=09if (!priv)
+=09if (!chan_args->priv)
 =09=09args->internalFlags =3D NVDEF(NV_KERNELCHANNEL, ALLOC_INTERNALFLAGS,=
 PRIVILEGE, USER);
 =09else
 =09=09args->internalFlags =3D NVDEF(NV_KERNELCHANNEL, ALLOC_INTERNALFLAGS,=
 PRIVILEGE, ADMIN);
@@ -180,11 +179,20 @@ r535_chan_ramfc_write(struct nvkm_chan *chan, u64 off=
set, u64 length, u32 devm,
 =09if (!chan->rm.mthdbuf.ptr)
 =09=09return -ENOMEM;
=20
+=09struct nvkm_rm_chan_alloc_args chan_args =3D {
+=09=09.nv2080_engine_type =3D eT,
+=09=09.runq =3D chan->runq,
+=09=09.priv =3D priv,
+=09=09.chid =3D chan->id,
+=09=09.inst_addr =3D chan->inst->addr,
+=09=09.userd_addr =3D nvkm_memory_addr(chan->userd.mem) + chan->userd.base=
,
+=09=09.mthdbuf_addr =3D chan->rm.mthdbuf.addr,
+=09=09.vmm =3D chan->vmm,
+=09=09.gpfifo_offset =3D offset,
+=09=09.gpfifo_length =3D length
+=09};
 =09ret =3D rmapi->fifo->chan.alloc(&chan->vmm->rm.device, NVKM_RM_CHAN(cha=
n->id),
-=09=09=09=09      eT, chan->runq, priv, chan->id, chan->inst->addr,
-=09=09=09=09      nvkm_memory_addr(chan->userd.mem) + chan->userd.base,
-=09=09=09=09      chan->rm.mthdbuf.addr, chan->vmm, offset, length,
-=09=09=09=09      &chan->rm.object);
+=09=09=09=09      &chan_args, &chan->rm.object);
 =09if (ret)
 =09=09return ret;
=20
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gr.c b/drivers=
/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gr.c
index 034db286d285..4bec793a2caf 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gr.c
@@ -301,12 +301,20 @@ r535_gr_oneinit(struct nvkm_gr *base)
 =09if (ret)
 =09=09goto done;
=20
+=09struct nvkm_rm_chan_alloc_args chan_args =3D {
+=09=09.nv2080_engine_type =3D 1,
+=09=09.runq =3D 0,
+=09=09.priv =3D true,
+=09=09.chid =3D rm->api->fifo->rsvd_chids,
+=09=09.inst_addr =3D nvkm_memory_addr(golden.inst),
+=09=09.userd_addr =3D nvkm_memory_addr(golden.inst) + 0x1000,
+=09=09.mthdbuf_addr =3D nvkm_memory_addr(golden.inst) + 0x2000,
+=09=09.vmm =3D golden.vmm,
+=09=09.gpfifo_offset =3D 0,
+=09=09.gpfifo_length =3D 0x1000
+=09};
 =09ret =3D rm->api->fifo->chan.alloc(&golden.vmm->rm.device, NVKM_RM_CHAN(=
0),
-=09=09=09=09=091, 0, true, rm->api->fifo->rsvd_chids,
-=09=09=09=09=09nvkm_memory_addr(golden.inst),
-=09=09=09=09=09nvkm_memory_addr(golden.inst) + 0x1000,
-=09=09=09=09=09nvkm_memory_addr(golden.inst) + 0x2000,
-=09=09=09=09=09golden.vmm, 0, 0x1000, &golden.chan);
+=09=09=09=09=09&chan_args, &golden.chan);
 =09if (ret)
 =09=09goto done;
=20
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fifo.c b/drive=
rs/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fifo.c
index 79132805cfcf..e28c7251ea10 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fifo.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fifo.c
@@ -17,15 +17,14 @@
 #define CHID_PER_USERD 8
=20
 static int
-r570_chan_alloc(struct nvkm_gsp_device *device, u32 handle, u32 nv2080_eng=
ine_type, u8 runq,
-=09        bool priv, int chid, u64 inst_addr, u64 userd_addr, u64 mthdbuf=
_addr,
-=09=09struct nvkm_vmm *vmm, u64 gpfifo_offset, u32 gpfifo_length,
+r570_chan_alloc(struct nvkm_gsp_device *device, u32 handle,
+=09=09const struct nvkm_rm_chan_alloc_args *chan_args,
 =09=09struct nvkm_gsp_object *chan)
 {
 =09struct nvkm_gsp *gsp =3D device->object.client->gsp;
 =09struct nvkm_fifo *fifo =3D gsp->subdev.device->fifo;
-=09const int userd_p =3D chid / CHID_PER_USERD;
-=09const int userd_i =3D chid % CHID_PER_USERD;
+=09const int userd_p =3D chan_args->chid / CHID_PER_USERD;
+=09const int userd_i =3D chan_args->chid % CHID_PER_USERD;
 =09NV_CHANNELGPFIFO_ALLOCATION_PARAMETERS *args;
=20
 =09args =3D nvkm_gsp_rm_alloc_get(&device->object, handle,
@@ -33,14 +32,14 @@ r570_chan_alloc(struct nvkm_gsp_device *device, u32 han=
dle, u32 nv2080_engine_ty
 =09if (WARN_ON(IS_ERR(args)))
 =09=09return PTR_ERR(args);
=20
-=09args->gpFifoOffset =3D gpfifo_offset;
-=09args->gpFifoEntries =3D gpfifo_length / 8;
+=09args->gpFifoOffset =3D chan_args->gpfifo_offset;
+=09args->gpFifoEntries =3D chan_args->gpfifo_length / 8;
=20
 =09args->flags  =3D NVDEF(NVOS04, FLAGS, CHANNEL_TYPE, PHYSICAL);
 =09args->flags |=3D NVDEF(NVOS04, FLAGS, VPR, FALSE);
 =09args->flags |=3D NVDEF(NVOS04, FLAGS, CHANNEL_SKIP_MAP_REFCOUNTING, FAL=
SE);
-=09args->flags |=3D NVVAL(NVOS04, FLAGS, GROUP_CHANNEL_RUNQUEUE, runq);
-=09if (!priv)
+=09args->flags |=3D NVVAL(NVOS04, FLAGS, GROUP_CHANNEL_RUNQUEUE, chan_args=
->runq);
+=09if (!chan_args->priv)
 =09=09args->flags |=3D NVDEF(NVOS04, FLAGS, PRIVILEGED_CHANNEL, FALSE);
 =09else
 =09=09args->flags |=3D NVDEF(NVOS04, FLAGS, PRIVILEGED_CHANNEL, TRUE);
@@ -62,30 +61,30 @@ r570_chan_alloc(struct nvkm_gsp_device *device, u32 han=
dle, u32 nv2080_engine_ty
 =09args->flags |=3D NVDEF(NVOS04, FLAGS, MAP_CHANNEL, FALSE);
 =09args->flags |=3D NVDEF(NVOS04, FLAGS, SKIP_CTXBUFFER_ALLOC, FALSE);
=20
-=09args->hVASpace =3D vmm->rm.object.handle;
-=09args->engineType =3D nv2080_engine_type;
+=09args->hVASpace =3D chan_args->vmm->rm.object.handle;
+=09args->engineType =3D chan_args->nv2080_engine_type;
=20
-=09args->instanceMem.base =3D inst_addr;
+=09args->instanceMem.base =3D chan_args->inst_addr;
 =09args->instanceMem.size =3D fifo->func->chan.func->inst->size;
 =09args->instanceMem.addressSpace =3D 2;
 =09args->instanceMem.cacheAttrib =3D 1;
=20
-=09args->userdMem.base =3D userd_addr;
+=09args->userdMem.base =3D chan_args->userd_addr;
 =09args->userdMem.size =3D fifo->func->chan.func->userd->size;
 =09args->userdMem.addressSpace =3D 2;
 =09args->userdMem.cacheAttrib =3D 1;
=20
-=09args->ramfcMem.base =3D inst_addr;
+=09args->ramfcMem.base =3D chan_args->inst_addr;
 =09args->ramfcMem.size =3D 0x200;
 =09args->ramfcMem.addressSpace =3D 2;
 =09args->ramfcMem.cacheAttrib =3D 1;
=20
-=09args->mthdbufMem.base =3D mthdbuf_addr;
+=09args->mthdbufMem.base =3D chan_args->mthdbuf_addr;
 =09args->mthdbufMem.size =3D fifo->rm.mthdbuf_size;
 =09args->mthdbufMem.addressSpace =3D 1;
 =09args->mthdbufMem.cacheAttrib =3D 0;
=20
-=09if (!priv)
+=09if (!chan_args->priv)
 =09=09args->internalFlags =3D NVDEF(NV_KERNELCHANNEL, ALLOC_INTERNALFLAGS,=
 PRIVILEGE, USER);
 =09else
 =09=09args->internalFlags =3D NVDEF(NV_KERNELCHANNEL, ALLOC_INTERNALFLAGS,=
 PRIVILEGE, ADMIN);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gr.c b/drivers=
/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gr.c
index 8dd4552aeaa5..354562ba9d35 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gr.c
@@ -130,12 +130,20 @@ r570_gr_scrubber_init(struct r535_gr *gr)
 =09if (ret)
 =09=09goto done;
=20
+=09struct nvkm_rm_chan_alloc_args chan_args =3D {
+=09=09.nv2080_engine_type =3D NV2080_ENGINE_TYPE_GR0,
+=09=09.runq =3D 0,
+=09=09.priv =3D false,
+=09=09.chid =3D gr->scrubber.chid,
+=09=09.inst_addr =3D nvkm_memory_addr(gr->scrubber.inst),
+=09=09.userd_addr =3D nvkm_memory_addr(gr->scrubber.inst) + 0x1000,
+=09=09.mthdbuf_addr =3D nvkm_memory_addr(gr->scrubber.inst) + 0x2000,
+=09=09.vmm =3D gr->scrubber.vmm,
+=09=09.gpfifo_offset =3D 0,
+=09=09.gpfifo_length =3D 0x1000,
+=09};
 =09ret =3D rm->api->fifo->chan.alloc(&gr->scrubber.vmm->rm.device, KGRAPHI=
CS_SCRUBBER_HANDLE_CHANNEL,
-=09=09=09=09=09NV2080_ENGINE_TYPE_GR0, 0, false, gr->scrubber.chid,
-=09=09=09=09=09nvkm_memory_addr(gr->scrubber.inst),
-=09=09=09=09=09nvkm_memory_addr(gr->scrubber.inst) + 0x1000,
-=09=09=09=09=09nvkm_memory_addr(gr->scrubber.inst) + 0x2000,
-=09=09=09=09=09gr->scrubber.vmm, 0, 0x1000, &gr->scrubber.chan);
+=09=09=09=09=09&chan_args, &gr->scrubber.chan);
 =09if (ret)
 =09=09goto done;
=20
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h b/drivers/gpu/=
drm/nouveau/nvkm/subdev/gsp/rm/rm.h
index b77059e0ac12..b71ba74eec12 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
@@ -31,6 +31,19 @@ struct nvkm_rm_wpr {
 =09bool is_libos2;
 };
=20
+struct nvkm_rm_chan_alloc_args {
+=09u32 nv2080_engine_type;
+=09u8 runq;
+=09bool priv;
+=09int chid;
+=09u64 inst_addr;
+=09u64 userd_addr;
+=09u64 mthdbuf_addr;
+=09struct nvkm_vmm *vmm;
+=09u64 gpfifo_offset;
+=09u32 gpfifo_length;
+};
+
 struct nvkm_rm_api {
 =09const struct nvkm_rm_api_gsp {
 =09=09int (*libos_init)(struct nvkm_gsp *);
@@ -113,9 +126,7 @@ struct nvkm_rm_api {
 =09=09int (*rc_triggered)(void *priv, u32 fn, void *repv, u32 repc);
 =09=09struct {
 =09=09=09int (*alloc)(struct nvkm_gsp_device *, u32 handle,
-=09=09=09=09     u32 nv2080_engine_type, u8 runq, bool priv, int chid,
-=09=09=09=09     u64 inst_addr, u64 userd_addr, u64 mthdbuf_addr,
-=09=09=09=09     struct nvkm_vmm *, u64 gpfifo_offset, u32 gpfifo_length,
+=09=09=09=09     const struct nvkm_rm_chan_alloc_args *chan_args,
 =09=09=09=09     struct nvkm_gsp_object *);
 =09=09} chan;
 =09} *fifo;
--=20
2.55.0

