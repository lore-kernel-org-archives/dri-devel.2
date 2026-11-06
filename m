Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4011C606EEB2
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85661112C8C;
	Fri,  6 Nov 2026 09:21:55 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA17112C81
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 09:20:09 +0000 (UTC)
Received: from [172.100.0.8] (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowAA3QZLDm+1qczlrAA--.4926S2;
 Fri, 06 Nov 2026 17:20:03 +0800 (CST)
Subject: Re: [PATCH] drm/vc4: Fix firmware reference leak in vc4_hvs_bind()
From: Wentao Liang <vulab@iscas.ac.cn>
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Cc: David Airlie <airlied@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, kernel-list@raspberrypi.com,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <5f80ac77-c1f4-42cc-bdcd-e4222f72d853@igalia.com>
References: <20260916154137.2058618-1-vulab@iscas.ac.cn>
 <5f80ac77-c1f4-42cc-bdcd-e4222f72d853@igalia.com>
Date: Fri, 06 Nov 2026 09:12:00 -0000
Message-ID: <1793956320.2120331.7714293051882437691@iscas.ac.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: rQCowAA3QZLDm+1qczlrAA--.4926S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFW5Jw43ur47JFWrXFW5Wrg_yoWftrg_Cr
 yvk3srCw18WrWv9FZxGrsFvry3GayDuFW8ZrZ7A348XrW8JF47Wrs5t393Xr1xJ3yjvF1D
 ZFnrKrW3twnrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbakYjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
 s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
 kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
 Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q
 6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4I
 kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
 WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
 0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
 JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
 IYCTnIWIevJa73UjIFyTuYvjxUDdgADUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgDA2rtlHkcpQAAsc
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maíra,

Sorry for the very late reply, and thanks for the review.

You are right, and your suggestion is better than what I had.  Moving
the firmware lookup below the clock lookups keeps the reference close to
its use, and the two rpi_firmware_put() calls in the error paths are not
needed anymore.  The rpi_firmware_find_node() call moves with it, since
the device node reference it returns would otherwise be leaked by those
same error paths.  I am sending v2 with that change.

About the other patch, "drm/vc4: Fix firmware reference leak in
vc4_drm_bind()": the same change would work there, since the only thing
between the firmware lookup and rpi_firmware_property() is
aperture_remove_all_conflicting_devices(), which does not use the
reference.  That patch was already applied as b816da5d5df1 before this
comment, so it is in the tree as posted, with the extra
rpi_firmware_put() in the aperture error path.

Thanks,
Wentao

