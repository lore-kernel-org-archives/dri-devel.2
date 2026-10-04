Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E021DCA5FF7
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E9E10EAF6;
	Sun,  4 Oct 2026 17:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=solom-dev.20251104.gappssmtp.com header.i=@solom-dev.20251104.gappssmtp.com header.b="LKpBuAgF";
	dkim-atps=neutral
Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com
 [74.125.231.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06A3210E2F6
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 00:42:03 +0000 (UTC)
Received: by mail-oo2-f42.google.com with SMTP id
 46e09a7af769-81be5042c51so1188421a34.1
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 17:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791074523; cv=none;
 d=google.com; s=arc-20260327;
 b=ZoNqtHFmV7O7DAyMJl50bWBBluYvGLey6zcORN65l/ZDij5EjheW8kCuv2qWbumAF6
 HactB+dVBPpnj/NqAlfQ0CUYgumOYkVSsgf4IKNC/WRvq29/t5fjnul928JikdLJTQms
 VOySbdZrotAf0Ph5OyadAyrD5SeAH1tFkh1OhrdWQE+FLD0E03XzmopC1OLuPLlNnvTN
 YxVTFq1RNEro3eXucQIYraDGGmkVMY83+tkdHiCPSHG0jpjEVp09Pt0SacTwf9thlrjG
 fF3C9FB+PQZrm26u2jY0ziXOogF3NuaxH5R0cThHX8NrjqxRzVCxsU1L+swPWlDDWw24
 4nLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=yz8y+ZWxaN6SYlrNOvWQGh0SwawyuvVdxArSOnuaZ8Q=;
 fh=dWsQw0EYTram8vLGsOL1J4wUg+u6UAF9Zmz+X95Drw0=;
 b=fBq3GVyceLQoTO/FPVNAyGkra7kV+TZknddu9BumNIlr/bS16Eer6LbvflWIkzU5Hw
 Bb/7X6cbCvnfhNfsNvYYq1Qdza1ywdc5OZivdqAKOh6PHDRW5uVIGKTdobdQf8CejcVB
 +f/33MSZnMjH6nH87pXgQHUGvrMxtwuRr9lNxtihh+PthziD7W9jjNA03qjI2CYqwYjy
 ZCrF5dEWXLHjth/gp3JQKH30CnLUHInWMLvA8w+DtxOrB8rveg4axFcbxykuSla9Ek9D
 4TnGzfg3YIjVMuTfMzv4lkToGp9bRN8OGfX+JdyCumqV9HoOwBrKZ8cIv6Zxeaq97xfC
 Epmw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solom-dev.20251104.gappssmtp.com; s=20251104; t=1791074523; x=1791679323;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yz8y+ZWxaN6SYlrNOvWQGh0SwawyuvVdxArSOnuaZ8Q=;
 b=LKpBuAgF7/HYH8o768h/dIyN9jjB6ewbiEGqqnu+2Mjil5hGQOmfZ3c4O/fKugE3xd
 LgzFBoSuMET2ENkzLpIk+/SrY6FXPmi19MqhnlncBLJpuyJczrEtyiRgiMVkjrBjcVcm
 qqzh32JEy/+bGm0Iqc9XDOykb+uTIzSaEqsLir1l6/XbFuuNFPDcnA+p7+3Tqy3bZdqf
 DZH1lCRnQBajzXoA60p4r09ql15xQh9nyBhn1dHSUpgN0tUEhghQRRrbEZ4/loYgEJhL
 ReJJNA+QXhkfIfenaSLpehQ91fLNdlvXkGpTfWgzbY3VsA4E9mwjNyEIQEksn+K7RsIk
 IdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791074523; x=1791679323;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yz8y+ZWxaN6SYlrNOvWQGh0SwawyuvVdxArSOnuaZ8Q=;
 b=DqV9fLN4GavDFRuplMNbxejiLTMTRF/ExDgMnntQwaVr5N+/7KOHLd5xS4zukIe9MB
 HZc+Fjh59ECnfA4pHGxYQsWyCfkWYsC+DDLDFb9qvOSDD/SSoXFKBhwL405rELumI/4n
 2v6YZWpCP5Clq2ngqqP+xT3YGpR/ahKcbW9Z1jKRmgvDIrE1aHYg5TstU4NHBHj9d/eK
 zKV6xS9E4vVHpdsdNcRaScS755JQ/6IjR6qJYCcNElWPWYY+6kOoYJmn9azR+t0QGljd
 vHmCCVDYQnhx6yiQU6iahLHI7qpj0lHJpqcBny73rEaES/inlQIHd0IivIhnsZoZcn7y
 C50Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNyJzVj9LpRMWJgJPQcdkbVfbedkwz8AM+1QKMt/sbwxLBe5pcJsTvFRXJzDvzgYbcHMsDyJmsBpA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l7CMA/gLtkDYCxxh1McTXAlA48ijSYHEDdN+ZUFiF0o62Jwbp5
 9A5SU3+BWg6CDdElanwQJ2poUUbFChmCO2axjsEq1/7yaE47H/A+JXj6UyUOH3N3DMqOz9VUMSv
 DV3VhULzCk6PZjvjKN8LGCj5K9mkfFxvP/fga/yT78A==
X-Gm-Gg: AYBFou3RqwdCy3CwyYD+tvB+nWFmCgPl5pppJDuevjxumq2F3q7oCahJg1cWXO9JZRu
 N31P4MWW4U/lJkdYnRoc68jJOi+7cfBDlchDibCqidrMstOr7ZvnpUHCe3DjdnwY/I+DupOhacv
 Ut6NOOSchTLWiLnodJ8Ot+0LPO587RfRzh/fBwpC+8GTQXfFHZCCXgielPK70pnjsgCkUnBiZgr
 WgK+YMp9isrpvIRDs6qIVUhaa5DqWyk/fot4VcS01bH1o68+/RTJHIKZissJhGFipjSwJ9qKnlv
 AXahIyGgxGSacOiZGZn/1PemJuBc6U3TopI3gMmyVqdqbjTlHpeboUAf8t3Cy65pZRc=
X-Received: by 2002:a05:6809:53:20b0:4f5:cb60:33c5 with SMTP id
 5614622812f47-4f5cb603dfbmr3485965b6e.6.1791074522839; Sat, 03 Oct 2026
 17:42:02 -0700 (PDT)
MIME-Version: 1.0
From: Solom Tamawy <solom@solom.dev>
Date: Sat, 3 Oct 2026 17:41:52 -0700
X-Gm-Features: AclHuK-uRUXQjKtvXJpq4QctVEAPOr84ph67KwJ7gm3zkr-Y0shQUBKodqrNHfI
Message-ID: <CACbN=AsQdd1GsAA1FpNMZCrd4YNHidX_dQ1CmBW4zYUnHbrioQ@mail.gmail.com>
Subject: [PATCH] drm/nouveau/kms: defer window LUT disable until the image
 update
To: nouveau@lists.freedesktop.org
Cc: Solom Tamawy <solom@solom.dev>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

A modeset on one head can set flush_disable for the entire atomic
commit while another window changes from an integer framebuffer to
FP16 without a modeset. The latter sets clr.xlut and set.image, but
not clr.image.

nv50_wndw_flush_clr() clears that window's ILUT before the intermediate
disable UPDATE, leaving the old integer image enabled without its LUT.
The new FP16 image is only programmed later in nv50_wndw_flush_set().
On hardware that uses the ILUT to convert integer input to the internal
FP16 pipeline, the intermediate state is invalid.

This ordering defect was found while investigating a Plasma login hang
on GB205 after atomic modesetting became enabled by default. The failure
logs contained window UPDATE exceptions followed by a core notifier
timeout:

   gsp: Xid:56 CMDre 00000001 00000200 00000001 00000005 0000002d
   gsp: Xid:56 CMDre 00000005 00000200 00000001 00000005 0000002d
   drm: core notifier timeout

Defer the LUT clear until the image update when the old image remains
enabled across a separate disable UPDATE. The LUT clear and new image
then take effect together. Keep early clears for windows whose images
are disabled and preserve the path without a separate disable UPDATE.
Pass flush_disable explicitly to the set phase, since the new plane
state's atomic-state backpointer is cleared during state swap.

Fixes: ebf8ca6b3d6d ("drm/nouveau/kms/nv50-: disable input lut harder")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Solom Tamawy <solom@solom.dev>
---
Based on linux-next f0406245cb9855e6318335a8a223551354291a46
(next-20261002). This is the functional fix only; atomic modesetting
remains enabled and the advertised formats are unchanged.

Testing:
- A focused C harness extracts the actual pristine and patched flush
   helpers and models two heads at each UPDATE boundary. The pristine
   helpers fail the mixed-head integer-to-FP16 case; the patched helpers
   pass all 14 cases. The model is not a full GPU simulator.
- Nouveau built against the matching kernel configuration and headers
   with successful modpost and BTF generation and no build warnings.
- I successfully logged into Plasma Wayland on RTX 5070
   (GB205), with three NVIDIA DP displays, amdgpu active on the integrated
   GPU, and a CalDigit TS5 Plus dock connected before login. No atomic=0
   override or USB/PCIe/Thunderbolt PM workarounds were present. The
   expected patched module was loaded, and the I confirmed a
   successful DRM_CLIENT_CAP_ATOMIC=1 capability probe. No Xid or core
   notifier timeout appeared in this boot.

  drivers/gpu/drm/nouveau/dispnv50/disp.c |  2 +-
  drivers/gpu/drm/nouveau/dispnv50/wndw.c | 13 ++++++++++++-
  drivers/gpu/drm/nouveau/dispnv50/wndw.h |  4 ++--
  3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index e91130f93db6..b7022a9b6e6f 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2351,7 +2351,7 @@ nv50_disp_atomic_commit_tail(struct
drm_atomic_commit *state)
                     (!asyw->clr.mask || atom->flush_disable))
                         continue;

-               nv50_wndw_flush_set(wndw, interlock, asyw);
+               nv50_wndw_flush_set(wndw, interlock,
atom->flush_disable, asyw);
         }

         /* Flush update. */
diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
index 74eb1dfcc043..ac59219e162a 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
@@ -137,6 +137,14 @@ nv50_wndw_flush_clr(struct nv50_wndw *wndw, u32
*interlock, bool flush,
         union nv50_wndw_atom_mask clr = {
                 .mask = asyw->clr.mask & ~(flush ? 0 : asyw->set.mask),
         };
+
+       /* A different head can require a separate disable update while this
+        * window only changes format. Keep its LUT enabled for the old
image
+        * until the new image is programmed: integer formats require an
ILUT.
+        */
+       if (flush && !clr.image && asyw->set.image)
+               clr.xlut = false;
+
         if (clr.sema ) wndw->func-> sema_clr(wndw);
         if (clr.ntfy ) wndw->func-> ntfy_clr(wndw);
         if (clr.xlut ) wndw->func-> xlut_clr(wndw);
@@ -147,7 +155,7 @@ nv50_wndw_flush_clr(struct nv50_wndw *wndw, u32
*interlock, bool flush,
  }

  void
-nv50_wndw_flush_set(struct nv50_wndw *wndw, u32 *interlock,
+nv50_wndw_flush_set(struct nv50_wndw *wndw, u32 *interlock, bool flush,
                     struct nv50_wndw_atom *asyw)
  {
         if (interlock[NV50_DISP_INTERLOCK_CORE]) {
@@ -157,6 +165,9 @@ nv50_wndw_flush_set(struct nv50_wndw *wndw, u32
*interlock,

         if (asyw->set.sema ) wndw->func->sema_set (wndw, asyw);
         if (asyw->set.ntfy ) wndw->func->ntfy_set (wndw, asyw);
+       /* Apply a deferred LUT disable together with the new image. */
+       if (flush && asyw->clr.xlut && !asyw->clr.image && asyw->set.image)
+               wndw->func->xlut_clr(wndw);
         if (asyw->set.image) wndw->func->image_set(wndw, asyw);

         if (asyw->set.xlut ) {
diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.h
b/drivers/gpu/drm/nouveau/dispnv50/wndw.h
index 7bd8bcc199db..b0b1b10cf782 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.h
@@ -40,8 +40,8 @@ int nv50_wndw_new_(const struct nv50_wndw_func *,
struct drm_device *,
                    const u32 *format, u32 heads,
                    enum nv50_disp_interlock_type, u32 interlock_data,
                    struct nv50_wndw **);
-void nv50_wndw_flush_set(struct nv50_wndw *, u32 *interlock,
-                        struct nv50_wndw_atom *);
+void nv50_wndw_flush_set(struct nv50_wndw *wndw, u32 *interlock, bool
flush,
+                        struct nv50_wndw_atom *asyw);
  void nv50_wndw_flush_clr(struct nv50_wndw *, u32 *interlock, bool flush,
                          struct nv50_wndw_atom *);
  void nv50_wndw_ntfy_enable(struct nv50_wndw *, struct nv50_wndw_atom *);

base-commit: f0406245cb9855e6318335a8a223551354291a46
