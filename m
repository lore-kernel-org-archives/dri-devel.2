Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B6BF53D65
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 15:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D8E10E3AF;
	Mon, 16 Mar 2026 15:31:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ll7nKHYP";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 707F610E3AF
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 15:31:33 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 6DC87C6C;
 Mon, 16 Mar 2026 16:30:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1773675020;
 bh=MVqO1eFsz7tJjRvRrGyugCvaQP/hH0/oExwBQll8Ol4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ll7nKHYP+oLxEurxLf5NUdQwDbEb45xiDRp/zinAgb1PmNYAIXQAD0pnqNMXYYHOH
 97L+T+0v8j5wPksts3PwzzKKvfJVvIhe34I9yciXOYrR2JdBmrSYxVmX4BhND/yxTP
 zfcitcb+YxebG+6eS+6fUEnGYEYbxXAoONAJc29c=
Date: Mon, 16 Mar 2026 17:31:30 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jyri Sarha <jyri.sarha@iki.fi>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 01/14] drm/atomic: Document atomic state lifetime
Message-ID: <20260316153130.GD31616@killaraus.ideasonboard.com>
References: <20260310-drm-mode-config-init-v1-0-de7397c8e1cf@kernel.org>
 <20260310-drm-mode-config-init-v1-1-de7397c8e1cf@kernel.org>
 <b0d9aee3-46c1-486d-9516-43ee23658f40@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0d9aee3-46c1-486d-9516-43ee23658f40@ideasonboard.com>
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

On Wed, Mar 11, 2026 at 08:44:24AM +0200, Tomi Valkeinen wrote:
> On 10/03/2026 18:06, Maxime Ripard wrote:
> > How drm_atomic_state structures and the various entity structures are
> > allocated and freed isn't really trivial, so let's document it.
> > 
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >  Documentation/gpu/drm-kms.rst |  6 +++++
> >  drivers/gpu/drm/drm_atomic.c  | 52 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 58 insertions(+)
> > 
> > diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
> > index 2292e65f044c3bdebafbb8f83dfe7ac12e831273..017c7b196ed7ead4cf5fa8572e1f977d9e00dda8 100644
> > --- a/Documentation/gpu/drm-kms.rst
> > +++ b/Documentation/gpu/drm-kms.rst
> > @@ -280,10 +280,16 @@ structure, ordering of committing state changes to hardware is sequenced using
> >  :c:type:`struct drm_crtc_commit <drm_crtc_commit>`.
> >  
> >  Read on in this chapter, and also in :ref:`drm_atomic_helper` for more detailed
> >  coverage of specific topics.
> >  
> > +Atomic State Lifetime
> > +---------------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/drm_atomic.c
> > +   :doc: state lifetime
> > +
> >  Handling Driver Private State
> >  -----------------------------
> >  
> >  .. kernel-doc:: drivers/gpu/drm/drm_atomic.c
> >     :doc: handling driver private state
> > diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> > index 4283ab4d06c581727cc98b1dc870bf69691ea654..92c6afc8f22c8307a59dc266aacdb8e03351409d 100644
> > --- a/drivers/gpu/drm/drm_atomic.c
> > +++ b/drivers/gpu/drm/drm_atomic.c
> > @@ -45,10 +45,62 @@
> >  #include <drm/drm_colorop.h>
> >  
> >  #include "drm_crtc_internal.h"
> >  #include "drm_internal.h"
> >  
> > +/**
> > + * DOC: state lifetime
> > + *
> > + * &struct drm_atomic_state represents an update to video pipeline
> > + * state. Despite its confusing name, it's actually a transient object

I wonder if we'll rename it one day :-)

> > + * that holds a state update as a collection of pointer to individual
> > + * objects states. &struct drm_atomic_state has a much shorter lifetime
> 
> Hmm, I think "a collection of pointers to individual object states". Hmm
> or "objects' states"? I like the former.
> 
> > + * than the objects states, since it's only allocated while preparing,
> 
> "objects' states" or "object states".
> 
> > + * checking or doing the update, while object states are allocated while

Maybe s/doing/committing/ if you want to use KMS terms.

> > + * the state will be, or is active in the hardware.

The second part sounds weird. I'd write

"while object states are allocated when preparing the update and kept
alive as long as they are active in the hardware."

or something similar. Writing "device" instead of "hardware" could also
be better.

> > + *
> > + * Their respective lifetimes are:
> > + *
> > + * - at reset time, the object reset implementation will allocate a new,
> > + *   default, state and will store it in the object state pointer.

s/default,/default/

> 
> "object's". This is the "active state", is it?
> 
> > + *
> > + * - whenever a new update is needed:
> > + *
> > + *   + we allocate a new &struct drm_atomic_state using drm_atomic_state_alloc().

The first part doesn't use first person pronouns, you may want to be
consistent across the whole text and use a descriptive style here too.

> > + *
> > + *   + we copy the state of each affected entity into our &struct
> > + *     drm_atomic_state using drm_atomic_get_plane_state(),
> > + *     drm_atomic_get_crtc_state(), drm_atomic_get_connector_state(), or
> > + *     drm_atomic_get_private_obj_state(). That state can then be
> > + *     modified.
> 
> Maybe clarify what is the state returned by these. It's the "active
> state", isn't it, drm_crtc.state or similar?

Yes, it's not very clear. The text should describe whether the
drm_atomic_state just points to the active state of the entities, or
duplicates them. "copy the state" is ambiguous.

> > + *
> > + *     At that point, &struct drm_atomic_state stores three state
> > + *     pointers for that particular entity: the old, new, and existing

s/that particular/any affected/

> > + *     (called "state") states. The old state is the state currently
> > + *     active in the hardware, which is either the one initialized by
> > + *     reset() or a newer one if a commit has been made. The new state
> > + *     is the state we just allocated and we might eventually commit to
> > + *     the hardware. The existing state points to the state we'll
> > + *     eventually have to free when the drm_atomic_state will be
> > + *     destroyed, but points to the new state for now.

s/but/and/

> From this, I don't understand the difference between the old state and
> the existing state. And if the existing state is the one we'll free,
> isn't that the old state, not new state? Oh, is the existing state a
> state we have to free when the drm_atomic_state would is freed? And at
> this point the new state is the one, as it's not committed?
> 
> > + *
> > + *   + After the state is populated, it is checked. If the check is
> > + *     successful, the update is committed. Part of the commit is a call
> > + *     to drm_atomic_helper_swap_state() which will turn the new states
> > + *     into the active states. Doing so involves updating the objects
> 
> "object's"
> 
> > + *     state pointer (&drm_crtc.state or similar) to point to the new
> > + *     state, and the existing states will now point to the old states,
> > + *     that used to be active but isn't anymore.
> 
> "aren't"
> 
> I think I understand this, but... It kind of brings in a new state
> concept, "active state".
> 
> > + *
> > + *   + When the commit is done, and when all references to our &struct
> > + *     drm_atomic_state are put, drm_atomic_state_clear() runs and will
> > + *     free all the old states.

Technically you're freeing the "existing" state per your nomenclature
above, which points to the old state. The word "existing" seems to make
things harder to describe, there may be an opportunity for better
vocabulary.

> > + *
> > + *   + Now, we don't have any active &struct drm_atomic_state anymore,
> > + *     and only the entity active states remain allocated.
> > + */
> > +
> 
> Even if this is a bit hard to read, I think it really clarifies the
> state lifetime.

It's certainly a useful addition to the documentation.

-- 
Regards,

Laurent Pinchart
