Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022EB606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bKgvia9R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53AF110E5D4;
	Mon,  9 Nov 2026 21:19:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF56B10E5D4
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 21:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794259152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ys5Qf2sygdYEIFynp57C8hwiHZBH3l4ISJ1KIFMKM7s=;
 b=bKgvia9RvQP2elnSbHn+Y9MkNbqncetAUWkK5WNhWoW1h94SLXHc7NkO1FSL36yksATPMd
 bDNvidJYcbduugkqLJ8JN4gXvfEBhOh4Xbafc+VfMP64O9meG8lGnHtC2ZJ98q+fPYbNaq
 Qjk8vaV9MIVfa0E9Jizy20iKEuoxLEU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-swXSuUpGO_yggDhmKaAfZQ-1; Mon, 09 Nov 2026 16:19:11 -0500
X-MC-Unique: swXSuUpGO_yggDhmKaAfZQ-1
X-Mimecast-MFC-AGG-ID: swXSuUpGO_yggDhmKaAfZQ_1794259151
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8b342fea533so13138487b3.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 13:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794259150; x=1794863950;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ys5Qf2sygdYEIFynp57C8hwiHZBH3l4ISJ1KIFMKM7s=;
 b=nv5vOmztbJV/l5tHXIAHfpXciuTJdhL4nOqScVEpicF7eq4HqwYpr6GEbHbN1CaADj
 e1cTX54aUk/FdHlJhnV03MZQghibT39qLI5FyjEnACwgMM4JpaEfGt4ACRnQ5EDlRIsN
 rGgbpiY5ureZhTkjwjsY/GPM+kU/AlmZIB4tyo1TMzGDk5FBrjJq3ZVK6xDetlKH1TyT
 FVO4j2FGIxHhvrsQvTa8WZC0wrL5ORVo6hwkBKpLr8lhBFHwOkTjEqHEpBHFWiyYlXVH
 UsxWhsoCSooz0LXO4VREZZG1itrtvLbU0IdwXo58ZD638oAc3FqG7ROXFt08hkrxlW8j
 GSSQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGNX4hGHlOm5hxqWDfIc6R2xYHh+yGBqsfs4kaDK/+b790/VTTZorllpo5B7wykSR255qHkLfZCi3s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8nzVkiCcCMUzlQ9rbKr3v6GHGqYLV4riXrC7oMmWc2pALnuN16
 gMMigfnsRDGo3eDKbVr8GEHitsMRUlcxEgLmdxI8K0GW4cN9pGqF+8BYqmj8/0nf6/YSdOZbmwM
 kPw3lnswUnF+eHjKIfoqOOI7dSxlV/6Em2WK+rY3Ui8wsmn7C2J2L1dRES5u5u4waWF4R6Q==
X-Gm-Gg: AYBFou3Ljwp/I2sHO1zLXyFOm/2rNcxLGr3XET0Clg+4ZfxD98aV4ExohTK6yDYstM8
 fogGu0VFb/7mgwTfEAiQ/gGNDkMd341y6jyg/gnWZB6kOzmg7es2ZaBr/Is8xHHlPWXr9hd1+Yb
 qQTXRhjRcxFor8GzoRflqXNtujisczZWvWbACuFFmmsbLVjVF/VsXfTo9SdgkQ9rBpqCC8L+rLC
 Okq+GX7e2Jch0Q8XVYo4oJ3e8qIPVwCBqhCQ0/mG7r/PqDhXJP7W4MKwyULR+yYBN4lrqWtyDwZ
 R63h+N6WbttPhX73IoyfhX1j4UAcF5i0wuGrkqeDSJuQgA4mEs8VANkk34Dbfz5MtQ9W07RM1lK
 mOGRzvUMuaSDOlkAdRkjt6/Mf7xBPy9Z2qkOEOyshUSrND9GudS1L2IPaOc6nvhS9zXzvaWrPzk
 pF3EHD
X-Received: by 2002:a05:690c:a405:10b0:8b3:37e3:7515 with SMTP id
 00721157ae682-8b392c40b78mr2355777b3.67.1794259148204; 
 Mon, 09 Nov 2026 13:19:08 -0800 (PST)
X-Received: by 2002:a05:690c:a405:10b0:8b3:37e3:7515 with SMTP id
 00721157ae682-8b392c40b78mr2355587b3.67.1794259147674; 
 Mon, 09 Nov 2026 13:19:07 -0800 (PST)
Received: from alolivei-thinkpadp1gen7.rmtbr.csb
 ([2804:14c:bf20:840e:cd21:e2c1:d8ec:dfa8])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b39324bbf5sm4029017b3.1.2026.11.09.13.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:19:07 -0800 (PST)
From: Alexon Oliveira <alolivei@redhat.com>
To: Xiao Lu <xiaolu.xie@intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, imre.deak@intel.com, ville.syrjala@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Subject: Re: [PATCH v2 0/2] drm/i915/dp_mst: Avoid the 3 s ACT timeouts after
 the upstream HPD drops
Date: Mon,  9 Nov 2026 18:19:01 -0300
Message-ID: <20261109211901.1033425-1-alolivei@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101033535.2078860-1-xiaolu.xie@intel.com>
References: <20261101033535.2078860-1-xiaolu.xie@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IAYT6oc5Ow9xFBk23R3FEToIk_zKpYTj_4qFpdLzrCY_1794259151
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 01, 2026 at 11:35:33AM +0800, Xiao Lu wrote:
> drm/i915/dp_mst: Avoid the 3 s ACT timeouts after the upstream HPD drops

Tested on a ThinkPad P1 Gen 7 (Meteor Lake) with a Lenovo ThinkPad
Thunderbolt 4 Dock (Synaptics VMM6212 MST hub) driving a Samsung TV over
HDMI, Fedora 44 kernel 7.2.15-200.fc44 with drm_display_helper.ko and
i915.ko rebuilt with both patches. On 7.2 the intel_dp_retrain_link()
hunk of patch 2 applies to intel_dp.c instead of
intel_dp_link_training.c, with identical context.

Scenario: TV powered on from standby, which makes the dock drop the
upstream HPD and tears down the MST topology
(https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17741).
Same day, drm.debug=0x104, times relative to "MST device may have
disappeared":

                                  unpatched        patched
  "Failed to get ACT after 3000"  3x               none
  forced retrain on stale pipe    yes (+2.14 s)    no
  new TV connector connected      +8.44 s          +2.48 s
  stream enabled on new connector +13.02 s         +6.61 s
  TV button to picture (by hand)  20.8 s           13.4 s

The ~2 s HPD drop from the dock is unchanged, as expected.

Tested-by: Alexon Oliveira <alolivei@redhat.com>

