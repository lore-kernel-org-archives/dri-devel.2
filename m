Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235B1F55811
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 11:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E2CF10E1BF;
	Tue, 21 Apr 2026 11:50:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UlMXGrki";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 268BA10E1BF
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 11:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776772216; x=1808308216;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=7EgXSX2kbNsQTGNgx4ImlKGpezUOlRUpgOi4icXx1j8=;
 b=UlMXGrkiyzDfEUcD3khV6gsAfUAvHU8H1o7lN6Be5zBjFnAp0hQnffYl
 28UulsDnhqe4+8GZkMpq3r+j2AXC48ialeI9xGxI6LW7KZh1EqpnvcLgD
 glUFVkT+yY59jHJsZFbuuvNwCcRoLU/42xD4VHFyws6WUYQemaNRSTRY/
 ql9GzpCu6qBNF7pcoHs3mxIaeB7NGLOQG362c9nwGvS2Uf2wuUiDhAMSC
 C+33txsP377gTzNxNSFxe08kN+FTqYJxR0DbR5AayYW3gF44FnQA1Ig/Y
 OKdlYTrbri66x7AWUQWdyQUsZGlNxKeIzu45dwzUpDadJeQR2lTnkM0/t w==;
X-CSE-ConnectionGUID: DtgCzP/5RyuX8/RJ5UubCQ==
X-CSE-MsgGUID: D3f2v4WcSdumb59LwfriCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77577802"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="77577802"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 04:50:16 -0700
X-CSE-ConnectionGUID: B3auslJVR6GKADUigwj8Wg==
X-CSE-MsgGUID: yUjIc98WRBiNmeMG9f/VHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="231891388"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost)
 ([10.245.245.38])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 04:50:08 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Albert Esteve <aesteve@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, Rae Moar
 <raemoar63@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, Guenter Roeck
 <linux@roeck-us.net>, Linux Kernel Functional Testing <lkft@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, =?utf-8?Q?Ma=C3=ADra?= Canal
 <mcanal@igalia.com>,
 Alessandro Carminati <acarmina@redhat.com>, Simona Vetter
 <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v7 4/5] drm: Suppress intentional warning backtraces in
 scaling unit tests
In-Reply-To: <CADSE00JJq6fsYbkFN5hBD=-ZWsFG9p4_C55fp3MupMJQj0QCUQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-4-e8bc6e0f70de@redhat.com>
 <20260420144702.GM3102624@noisy.programming.kicks-ass.net>
 <CADSE00JJq6fsYbkFN5hBD=-ZWsFG9p4_C55fp3MupMJQj0QCUQ@mail.gmail.com>
Date: Tue, 21 Apr 2026 14:50:05 +0300
Message-ID: <8a9c125c08206296d698c79c3d3dd6aea36a7e3b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 21 Apr 2026, Albert Esteve <aesteve@redhat.com> wrote:
> On Mon, Apr 20, 2026 at 4:47=E2=80=AFPM Peter Zijlstra <peterz@infradead.=
org> wrote:
>>
>> On Mon, Apr 20, 2026 at 02:28:06PM +0200, Albert Esteve wrote:
>> > From: Guenter Roeck <linux@roeck-us.net>
>> >
>> > The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
>> > intentionally trigger warning backtraces by providing bad parameters to
>> > the tested functions. What is tested is the return value, not the exis=
tence
>> > of a warning backtrace. Suppress the backtraces to avoid clogging the
>> > kernel log and distraction from real problems.
>> >
>> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> > Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
>> > Acked-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> > Cc: David Airlie <airlied@gmail.com>
>> > Cc: Daniel Vetter <daniel@ffwll.ch>
>> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
>> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
>> > ---
>> >  drivers/gpu/drm/tests/drm_rect_test.c | 14 ++++++++++++++
>> >  1 file changed, 14 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/t=
ests/drm_rect_test.c
>> > index 17e1f34b76101..1dd7d819165e7 100644
>> > --- a/drivers/gpu/drm/tests/drm_rect_test.c
>> > +++ b/drivers/gpu/drm/tests/drm_rect_test.c
>> > @@ -409,8 +409,15 @@ static void drm_test_rect_calc_hscale(struct kuni=
t *test)
>> >       const struct drm_rect_scale_case *params =3D test->param_value;
>> >       int scaling_factor;
>> >
>> > +     /*
>> > +      * drm_rect_calc_hscale() generates a warning backtrace whenever=
 bad
>> > +      * parameters are passed to it. This affects all unit tests with=
 an
>> > +      * error code in expected_scaling_factor.
>> > +      */
>> > +     KUNIT_START_SUPPRESSED_WARNING(test);
>> >       scaling_factor =3D drm_rect_calc_hscale(&params->src, &params->d=
st,
>> >                                             params->min_range, params-=
>max_range);
>> > +     KUNIT_END_SUPPRESSED_WARNING(test);
>>
>> Would not something like:
>>
>>         scoped_kunit_suppress() {
>>                 scaling_factor =3D drm_rect_calc_hscale(&params->src, &p=
arams->dst,
>>                                                       params->min_range,=
 params->max_range);
>>         }
>>
>> be better?
>
> Since KUnit already has a few macros in its API it didn't occur to me.
> Good idea, I like it. And I guess the scope approach matches well with
> your __cleanup comment in the first patch. If no one opposes, I will
> work toward that pattern for the next version.

There's a catch with kunit and __cleanup and thus (scoped) guards. Kunit
runs in ktreads, asserts lead to kthread_exit() and the __cleanup won't
be called.

Warning suppression being part of kunit infrastructure, asserts can and
should end the suppression too. But setting the example (scoped) guards
are safe in kunit tests in general feels like a trap waiting to happen.


BR,
Jani.


>
>>
>> Also, how can you stand all this screaming in the code?
>>
>
> Again, KUnit already contains many macros, so this use didn't register
> as such. Now I will not be able to unsee it.
>
>

--=20
Jani Nikula, Intel
