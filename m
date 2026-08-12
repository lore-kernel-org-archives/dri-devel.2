Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F27CC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A7410EE72;
	Wed, 12 Aug 2026 07:08:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cGNnuBLb";
	dkim-atps=neutral
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 254D310E3C3
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 04:13:11 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-527e352a167so1810401cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786507991; x=1787112791; darn=lists.freedesktop.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WoA62XvqBE/bJkGlo+pvls7iLFgdIjTnZ2CNMnT1eiI=;
 b=cGNnuBLb0z05yr++njTiJKkeCokhgVNAU83+BLMWpejixDY/h1UsQK/OdeJJ128LAz
 kOy0wFZFFFcfuwcRK6dyiPfc/SCdbo7oH4ZuSXCEd0g7nMC3FJHbX0NDms0l5JYiD1yU
 vfEbkdXqgcweeTBSg9rmH9bJIj1C4dc723Uyz7Xtw1dKQbpLuScShE6pZAHXCtDuhUNk
 No3g4FQU66zemyWxeoegz5AHGTXpP7sJbhUbGdIBUKn7gvFw05Bqhvs2Zb1YTbcu3WfT
 Z2R2yXrEp7j7IZW15Oi4uac9fuyBkQqhlsQ5PU0SlAheOirXGHjh5ALzSDGbOwsI3UAN
 rhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786507991; x=1787112791;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WoA62XvqBE/bJkGlo+pvls7iLFgdIjTnZ2CNMnT1eiI=;
 b=FyKereYqyAs75EjWbL5vl3hecjaKvLu9tEgaLctw2I/yFX+6HCRB8wg+BVHm3mKNaR
 EKX9eT1020BMMkOkhMdfTF4MzY3tl9IjlfYxDNSf2rP+HT9Tq6qrurGSvr0FS9UcU0nd
 01IST9MBxbb44exdZHVpOXvfZl14FajS6lWH3y3T9/bH7BWpiVxcQZUmBArbcS4JTw7Q
 aVC27fvIQaVb91cSoiPYSLhyh312WNPq1T4r+1T1mBzLpXAKMYhTnig0mAIkhOw6dLrw
 1r5y4hiHL0XrX82/qFUSQ6vspH3uN78nwKJGmjmEzWkoUQobKxrU4SAPrWVtUa9heSg6
 HbzA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ros+9Dm4tG4+vG1ynkbeqQdlrCq8Sb80A+TM/h+QOTV5CvfgZyp0iZYABoO23ZOwVasooVE+i3bowM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySP0X0EX6LUkk0IPsRugj2KwptXKwCzuklwAbgtnuB52Mq70fP
 FEJBlZqcaW2opmquX6VsZQ6f0oCVau6RptFqMTjcfFf88EB2j/6w+WsZ
X-Gm-Gg: AR+sD13U4vW4apPFrjyZH+7vzDnYI8xcKscy5Apii/Xv6lzKe0ADP84jgBPhXR1CkFY
 0qnXossMqd3q9nqRRXWbr5ho79qNNEBk3CCyHOfggmbkkjq3ZoHtm7FhE9msqgZjxtfN/oX60Im
 tzVXDgaCid0b14iHCu8dwG7ZZc5WRmq1QlTZuEDHIs3WV+G2QOqIh7jAyb9haqtVGNZ7+/8x+M3
 HmHKcJTYORnT5K/4RZZjbUG1bpucgmNxS0NpluabNBcMvqPnBvKpVHFG/3z/ItxM2YBLytz4wH5
 ZchVfmVDbBVuOzs76H1il4Uz77p+jZ8ptvZhN3wYYQ0Y5Hy8CqZHvrlzIHlo+Kz2UMNN6TjCFkR
 VwAZ83IKFwGR7sBxFuG36qYsBRwjqKDBx9XhIKC2OcIT6CRCWQX9+31SOYBNgLUf9vauWwMuRTE
 XH8WmJuSCPnd4Ks9lGRd9tfzpMtv+brUhKAuYgxg2kNa0w9QKJ0Jw6ibSBEfYA9xPLqd5b/7Xja
 8yahpbZ8qnRRyLizLHW61Qhgrdhzn3m
X-Received: by 2002:a05:622a:a0a:b0:51c:1c2c:a8bc with SMTP id
 d75a77b69052e-52d6483fbfbmr18441601cf.37.1786507990610; 
 Tue, 11 Aug 2026 21:13:10 -0700 (PDT)
Received: from smtpclient.apple ([2600:1016:b10f:b114:6c29:917c:9735:8846])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d61e017bdsm10172371cf.27.2026.08.11.21.13.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Aug 2026 21:13:10 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] drm/i915/gem: Fix request use-after-free in
 active_engine()
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <zmincd7ubpkwasily6fegvx7mz6zkdw5oglbj3ynpgqovpkszh@un7lyxy6dgly>
Date: Wed, 12 Aug 2026 00:12:38 -0400
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, chris@chris-wilson.co.uk, stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0602E2B1-4FF4-4496-916D-D4DB1C1B0830@gmail.com>
References: <20260809173646.3292361-1-shuangpeng.kernel@gmail.com>
 <zmincd7ubpkwasily6fegvx7mz6zkdw5oglbj3ynpgqovpkszh@un7lyxy6dgly>
To: Krzysztof Karas <krzysztof.karas@intel.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:08:20 +0000
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

Hi Krzysztof,



> On Aug 11, 2026, at 05:37, Krzysztof Karas <krzysztof.karas@intel.com> =
wrote:
>=20
> Hi Shuangpeng,
>=20
> On 2026-08-09 at 13:36:46 -0400, Shuangpeng Bai wrote:
>> active_engine() walks timeline->requests in reverse under RCU and =
takes a
>> temporary reference before inspecting each request. However, it drops =
that
>> reference in the loop body before list_for_each_entry_reverse() =
advances
>> the cursor.
>>=20
>> Concurrent retirement can unlink the same request and drop its base
>> reference while active_engine() holds the temporary reference. The =
put in
>> active_engine() may then be final, freeing or recycling the request =
before
>> the loop step reads rq->link.prev. SLAB_TYPESAFE_BY_RCU does not =
defer that
>> reuse.
>>=20
>> Open-code the reverse walk and cache the previous request while the =
current
>> request is still referenced. The next request remains protected by
>> i915_request_get_rcu() and validated against the timeline before use.
>>=20
>> An i915 mock selftest forced retirement between the active check and =
cursor
>> advance. The vulnerable tree reached the final request release and
>> kmem_cache_free(), while the fixed tree completed the same ordering =
without
>> accessing rq after the put.
> What mock selftest are you referring to?
>=20

Thanks for looking.

The "i915 mock selftest" I referred to was a local temporary mock
selftest.

Because generic QEMU does not expose an Intel i915 PCI device, I
used the mock engine/request infrastructure to validate only the
ordering in active_engine(). In short, the test forces
active_engine() to hold the temporary request reference while a
worker on the other CPU retires the same request, so the
subsequent i915_request_put(rq) in active_engine() becomes the
final put. That was only meant to show that this interleaving is
feasible.

I can clarify that wording in v2.

>>=20
>> Fixes: 3cfea8c97c93 ("drm/i915/gem: Hold request reference for =
canceling an active context")
>> Cc: stable@vger.kernel.org # v5.10+
>> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>> ---
>> drivers/gpu/drm/i915/gem/i915_gem_context.c | 10 ++++++++--
>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c =
b/drivers/gpu/drm/i915/gem/i915_gem_context.c
>> index c58ffa5a8fa6..ff5c892a0176 100644
>> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
>> @@ -1361,7 +1361,7 @@ static bool __cancel_engine(struct =
intel_engine_cs *engine)
>> static struct intel_engine_cs *active_engine(struct intel_context =
*ce)
>> {
>> struct intel_engine_cs *engine =3D NULL;
>> - struct i915_request *rq;
>> + struct i915_request *rq, *prev;
>>=20
>> if (intel_context_has_inflight(ce))
>> return intel_context_inflight(ce);
>> @@ -1375,7 +1375,8 @@ static struct intel_engine_cs =
*active_engine(struct intel_context *ce)
>>  * (and onto a new timeline->requests list).
>>  */
>> rcu_read_lock();
>> - list_for_each_entry_reverse(rq, &ce->timeline->requests, link) {
>> + rq =3D list_last_entry(&ce->timeline->requests, typeof(*rq), link);
>> + while (!list_entry_is_head(rq, &ce->timeline->requests, link)) {
>> bool found;
>>=20
>> /* timeline is already completed upto this point? */
>> @@ -1387,9 +1388,14 @@ static struct intel_engine_cs =
*active_engine(struct intel_context *ce)
>> if (likely(rcu_access_pointer(rq->timeline) =3D=3D ce->timeline))
>> found =3D i915_request_active_engine(rq, &engine);
>>=20
>> + /* Cache the cursor before the put, which may release rq. */
>> + if (!found)
> You could skip this check here and unconditionally set "prev".
> Its value is going to be used only once if found =3D=3D false anyway.
>=20

Thanks for your comment. I'll simplify that by assigning prev
unconditionally before i915_request_put().

Please let me know if this addresses your question. If it does,
I'll send v2 with the wording clarified and prev assigned
unconditionally before i915_request_put().

Thanks,
Shuangpeng

>> + prev =3D list_prev_entry(rq, link);
>> i915_request_put(rq);
>> if (found)
>> break;
>> +
>> + rq =3D prev;
>> }
>> rcu_read_unlock();
>>=20
>>=20
>> base-commit: a59f57e2aa127c5354168d2ec4bac920df1be4f4
>> --=20
>> 2.43.0
>>=20
>=20
> --=20
> Best Regards,
> Krzysztof


