Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C779C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE8F310E54B;
	Mon,  6 Jul 2026 02:41:45 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E4910E54B
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 02:41:44 +0000 (UTC)
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-qAdnzgQbO3KdSj3kfVunCA-1; Sun,
 05 Jul 2026 22:41:38 -0400
X-MC-Unique: qAdnzgQbO3KdSj3kfVunCA-1
X-Mimecast-MFC-AGG-ID: qAdnzgQbO3KdSj3kfVunCA_1783305696
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5ED21801378; Mon,  6 Jul 2026 02:41:35 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AEB83000B4C; Mon,  6 Jul 2026 02:41:27 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org, tj@kernel.org, christian.koenig@amd.com,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Waiman Long <longman@redhat.com>, simona@ffwll.ch,
 intel-xe@lists.freedesktop.org
Subject: drm/ttm/memcg/lru: enable memcg tracking for ttm,
 xe and amdgpu driver (part 2).
Date: Mon,  6 Jul 2026 12:36:09 +1000
Message-ID: <20260706024122.853329-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jrRJuZjPMOfVKXTT_66HMGeOnWYylsMdlhJCDfTIFuQ_1783305696
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

I committed the vmstat counters and list lru changes, and they are now in t=
ree.

This is the remainder of this series. Intel have expressed interest in gett=
ing
this landed for xe, we can drop the amdgpu changes for now if they can't ge=
t
across the line.

I've dropped all previous acks/reviews.

This series adds the memcg counters for GPU active and GPU reclaim to align
with the two global vmstats. It adds an accounting flag to TTM alloc/popula=
te,
and enables memcg tracking and shrinker support in TTM.

Then it adds amdgpu and xe support.

I think for this to land, Christian holds the main objection which I still =
fail
to fully understand beyond it doesn't solve all the problems we ever have h=
ad
with cgroups and drm, so we shouldn't even bother, and maybe we could do it=
 at
the object level, and integrated with dmem, and android cross process accou=
nting,
but I still feel this is a good baseline.

I think this is the right layer to hook this into TTM, where we allocate me=
mory
and I think accounting for this memory in a proper way should be done.

Intel folks (Thomas/Maarten) please review and express concerns as well.

Regards,
Dave.

