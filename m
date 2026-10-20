Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A37606A326
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=OJYZ8vo1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D2E10F194;
	Tue, 20 Oct 2026 01:48:56 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17D2110F194
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 01:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792460929;
 bh=b8dt7ILauLndGVgIEIvkXYvCIjmzfLH15k6esv+BlNI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OJYZ8vo1r0xPuFH2vN/yTI3PXQrEXGJep0Zyzf8eKFVON/fPUVUh+sbdsH83cDPS8
 tOoGQcXvv0bcuP9uDn0T94v3lOOSgwCg+3etg0tEd32V1m7X7ytr0XXEUOqQZIVPr/
 KwH64gTgXyMzJLnkjzlWIlyjOh92VPX6jKxKNmWTNMykgjYgYQ0vxXRPvGhjMykitM
 YdvhHEQ4jNC4FPRSo76wK+NtYA19yxQBAXu3g1uj5hP+hWG5MqQJQuP8CXdHcAngQX
 Zk6oD5inHod2EZ4d2YvyFO+qqHtx8b6V6UqwLwAqX5D4PQBrovXxQuvd6ZCaAt/uSH
 zZ8L31OMdGwoQ==
Received: from [100.64.0.157] (unknown [100.64.0.157])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: vignesh)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DF68117E0382;
 Tue, 20 Oct 2026 03:48:46 +0200 (CEST)
Message-ID: <533a80fb-86db-46a2-a627-7db37bd8cbb7@collabora.com>
Date: Tue, 20 Oct 2026 07:18:44 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ci: Add CI pipeline for drm-misc branches
To: Maxime Ripard <mripard@kernel.org>
Cc: Helen Koike <helen.fornazier@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 llvm@lists.linux.dev
References: <20260911-drm-drm-misc-ci-v2-1-1847f89585cb@kernel.org>
 <9e1fc5c6-53ff-4a4d-9744-77bcf6a0325e@collabora.com> <atYoMnjtOhDLJwza@houat>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <atYoMnjtOhDLJwza@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maxime,

On 19/10/26 19:56, Maxime Ripard wrote:
> Hi Vignesh,
> 
> On Mon, Oct 19, 2026 at 03:30:54PM +0530, Vignesh Raman wrote:
>> Hi,
>>
>> On 11/09/26 17:48, Maxime Ripard wrote:
>>> The DRM CI infrastructure builds upon Mesa's CI to run IGT tests on
>>> hardware. Its focus is on functional testing on a selected number of
>>> targets.
>>>
>>> The concern for drm-misc is different: it merges a large number of
>>> patches across many platforms, and build or unit test breakages happen
>>> on a regular basis. Adding build and unit testing for drm-misc has been
>>> on the back of our minds, and a first attempt was made last year. The
>>> feedback was to rely more on the existing infrastructure.
>>>
>>> Introduce a CI entry point that runs on pushes to drm-misc-next,
>>> drm-misc-fixes, and drm-misc-next-fixes. It reuses kunit.yml,
>>> check-devicetrees.yml, and the freedesktop ci-templates, while defining
>>> build templates inline to avoid pulling in the Mesa pipeline.
>>>
>>> A single Debian container with LLVM handles cross-compilation to all
>>> three architectures. The pipeline compiles the kernel using defconfigs
>>> from the drm/tip rerere-cache branch, runs the DRM KUnit tests, and
>>> checks device tree bindings.
>>>
>>> Link: https://lore.kernel.org/all/20250319-greedy-sturgeon-from-avalon-ac758f@houat/
>>> Acked-by: Vignesh Raman <vignesh.raman@collabora.com>
>>> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>>> ---
>>> Changes in v2:
>>> - Run dt_bindings_check
>>> - Run on push instead of MR after some discussions with Dave and Sima
>>> - Test run here: https://gitlab.freedesktop.org/mripard/kernel/-/pipelines/1744733
>>> - Link to v1: https://lore.kernel.org/r/20260902-drm-drm-misc-ci-v1-1-49d05e228eab@kernel.org
>>
>> Acked-by: Vignesh Raman <vignesh.raman@collabora.com>
> 
> Thanks for the review, see below
> 
>>> ---
>>>    drivers/gpu/drm/ci/drm-misc-ci.yml | 147 +++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 147 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/ci/drm-misc-ci.yml b/drivers/gpu/drm/ci/drm-misc-ci.yml
>>> new file mode 100644
>>> index 000000000000..4ab87547794e
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/ci/drm-misc-ci.yml
>>> @@ -0,0 +1,147 @@
>>> +# CI pipeline for drm-misc-next, drm-misc-fixes, and drm-misc-next-fixes.
>>> +#
>>> +# Runs on pushes to drm-misc-next, drm-misc-fixes, and
>>> +# drm-misc-next-fixes. Compiles the kernel for arm, arm64, and
>>> +# x86_64, runs the DRM KUnit tests, and checks device tree bindings.
>>> +#
>>> +# A single container image is built using freedesktop ci-templates with
>>> +# the packages needed for kernel compilation and LLVM for
>>> +# cross-compilation. QEMU is installed at runtime by the KUnit jobs.
>>> +#
>>> +# check-devicetrees.yml and kunit.yml are included directly. build.yml
>>> +# and the Mesa container/build pipelines are not:
>>> +# they pull in hundreds of Mesa-specific jobs and templates that would
>>> +# each need to be individually stubbed or disabled. The build templates
>>> +# (.build:arm32, .build:arm64, .build:x86_64) are defined inline.
>>> +
>>> +variables:
>>> +  CI_TEMPLATES_COMMIT: &ci-templates-commit aec7a6ce7bb38902c70641526f6611e27141784a
>>> +  # Project whose container registry stores the built images
>>> +  FDO_UPSTREAM_REPO: mripard/kernel
>>> +  KERNEL_BUILD_CONTAINER_TAG: "2026-09-11-01"
>>> +  LLVM_VERSION: "19"
> 
> I just realised there's still my personal repo being used as the
> container registry. Are you ok if I change it to drm/misc/kernel when
> applying?


Yes, please change it when applying. Thanks.

Regards,
Vignesh

> 
> Thanks again,
> Maxime

