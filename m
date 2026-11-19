Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984A606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nc3nSf62;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=bc1zpM8K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5855D11274E;
	Thu, 19 Nov 2026 22:19:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C06311274B;
 Thu, 19 Nov 2026 22:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795126731; x=1826662731;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=HaffBkvVma3oN0d1thCSWpcXETm+Hs/J7W6NRM48f/E=;
 b=nc3nSf62yyJHnwg8gYicaIakKO85jfY62N/8DKQ8pkMZCAkgJovavhFc
 6mrQqd8cNMEd2UQnYLOA/z+EiPQeE8Yx5Aad8tZWIKs/9XuTOUqKYCfen
 TDU8OLiJ7eoxpt7reXAcvGltZkuDeNvE91xQ380+P1hAWhEFfTqNI/H48
 5mrEVFKlIvHHeKW3JNpqMpg8MWpiS9klGCmgePY9MAgowlqV+N9vpjVea
 aUQ9juwuFe00NhLexCLmbQyq0ew322FQBHxCXhTDetzuBzrl+ZFt8qusz
 80X3/boUCldIQf4B3onZMlPKFSDJdd2C9DQWv6K1nMm7xCH1ewHCW/Y2W A==;
X-CSE-ConnectionGUID: wIHh8Ks/RiaAjdrp7QG8vg==
X-CSE-MsgGUID: dzsWZaAUTwaXWWHHxQc2yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3885534"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3885534"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 14:18:50 -0800
X-CSE-ConnectionGUID: mfivitGRSGazJBKCVQr54w==
X-CSE-MsgGUID: 1wmu2/RWToOK0ygP1nY5Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10771314"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 14:18:50 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 14:18:48 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 14:18:48 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 14:18:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyYADx+tP3QC1IHaja1YllBG22uSNi+yIDB+PQtQfWb2s/GaNTO4j4RTREaKpePI95FAq4JGl7C4vLsBSwyQSz9SQK75ed54ayHkIYU9liz5i3KGh6j1LDyoRw3yEEUFNggl6ivNSsFBp518m9rthOyY29cKmhZW9PLr9t/dsg15qUk15XjZS7vjluntNlCNziK+Ccv5cGoVPaeZhb4Xv8QraRaR9n/jtbxubJa/Irm0HCNZ+lx96ZbgIxMRpkBcSMHWC3uggrta1xOOkjCpcGiOguKCrneE4oCR58iYyKsi9fhnKwHC9gz1VTmeoxvow2vhXUs8IGzS+5KUJ/MVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gv26LYvJyWL4F4cnWXvHrKt5AbYvgRZhNCtikMPFo/U=;
 b=AtI6pDu86Me8L/aUgQ+MAWQ0KjJyB/U5zf9U3ayc93NVynT7XMMASo1eVP9mtMa+K8CBw90FWhaQrOnQI21eze+DoJi2lb/D93c9DenCdXwPMF02L+PsiOfVGlY4Jj1upv3sD+1+mipXjIwXWgINasw3psrt7g/Z3Bw2MlHcdsQL3qKSdi0WJ81el55SDE+ybaJaQpivxEBwzU1niSwaanhndepqZdUwNYxYZv2b86qDJplM8TAT88pN8WhJppL4/VIfeoqRRnT4VGmQkNpjAHqM9poKQ4DI4hASTunpBQXEOwTXn0eOu9svUyCuHTdmCq5jT+7xBgRSn52+YhU6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv26LYvJyWL4F4cnWXvHrKt5AbYvgRZhNCtikMPFo/U=;
 b=bc1zpM8KMvgEpxSGcefAknFyU586Of7Gmq21xfjJPVRFJbyE/RXVdLkMO+88lowZIKbOYY/ZT9Hsrt0dVamVKzljyEU9K9EvUH7xciYGRMuqZNUOSLfNinK06yZQvvlA716NQFF2ww6OdHRrT7QWo0xJaIwy6qbTvLr2kbkm5hY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SJ1PR11MB6131.namprd11.prod.outlook.com (2603:10b6:a03:45e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 22:18:44 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 22:18:44 +0000
Date: Thu, 19 Nov 2026 14:18:42 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Oded
 Gabbay" <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <dim-tools@lists.freedesktop.org>
Subject: [PULL] drm-xe-fixes
Message-ID: <av91wsZ6Zg9vfrNn@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:303:b5::16) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SJ1PR11MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0fae46-62a4-4c4f-047c-08df468b130e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|261022105027099003|261026140227099003|261028144727099003|261021123027099003|56012099006|11063799006|261021121427099003|261102130727099003|10067099003|261009223027099003|261102123227099003|18002099003|261026121527099003|6133799003;
X-Microsoft-Antispam-Message-Info: ktMijsC07uOQPArT6l9vJs1pgN7i1hzA28YdpbdR871vj7H8nbioZJjvzoGCQUkizucq9cosatLxBGGuEN3pU37LbM7gyISf+HgghSuHiXRQ29nUfG43eEfOSCSSTMicXOYGex1ZRCiqVFPtL4mdV/VrIoJPQ5qKIhiACkUUuaFozShF5MZzaBxcEAMyBP4MEYkMPqezuSeB7fosw9pzv1i8Bt6ytnTFrj/Nh5XSCefBwYTlmUnAraU9U+f2Tue7Uhr8cPYEQmTqRACqzRp+3NbYIO7qq5UQ/IWGQ9CRkSoPPKTfxpmpuyQO/Q8GDKIkppzSZH60Y5LEvXbZCJ8lxZs6QiOLYm7KEgxR35V4EMcRAe1GH0J9ymmYoqvY9e4C0qzgvyLUno3fDWnEJQsI8pSzevQT8+i+eSUihLdrTHf3OhchSYuEDEbwk+agvuIithrsYcUJIIcnBgB9+9NWXM8DjI5DVz6NSTQVl2/PxksImZH9ymLfOctie3YV0bgtYwXq6yAbX4aODWL+LDltdg+euzL9cSvaZc1UGaIPi2hip1LLH+42K+vVDofV1/I36LbdsfvrCp5gDird39wGVpS5ZXnkqe1rT3LqWSMR6Ng=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(261022105027099003)(261026140227099003)(261028144727099003)(261021123027099003)(56012099006)(11063799006)(261021121427099003)(261102130727099003)(10067099003)(261009223027099003)(261102123227099003)(18002099003)(261026121527099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RDCd0lsf4WvOUFuE3bU2/huBzesNklXH7r46qqzq6EgnRqtrsPbzRhAAcx?=
 =?iso-8859-1?Q?3JC+yE0MGMziY4bzZjZGCdL9vIVV3tV4jQjlrNsrazuUR6EiOzNzDEpFGF?=
 =?iso-8859-1?Q?6wipxZpKyXFBwUF7GxD/YFi/KJBNAAELVitt04m4b5Xw8JKq/Hl5n9JQp7?=
 =?iso-8859-1?Q?vRKPnCcVattsS4C+njaZcSLBX5+77mZee80DmLKjYi1KjPpzifbXqlAG9W?=
 =?iso-8859-1?Q?d9Jon/PsBYyAXAYuDZ4O4aYDPtPP6QtEhTxlatMVmgCmszSHRyyvLm/7Nt?=
 =?iso-8859-1?Q?jmHvF6H64rkW1zRM859YeufNn2MeCS4VyqOlvXv161HVBzuDyGM+WDBXdp?=
 =?iso-8859-1?Q?yWEpRlzWu4DMMvvp8pL3hP6/YFvcGHBx/8gBgCU/3jIxVKZ1W3Uo7npSbs?=
 =?iso-8859-1?Q?ayWQZEvWtgJGkXFEqdLnuS9970dPJ+hQKD0ZFw35TYkI693SPmrIgkmJc1?=
 =?iso-8859-1?Q?y086ldEs21LYQVuA4w+Lr5ZEZUcNxLOYJEBl3p2slX7CfmcpZAGqdsCy3u?=
 =?iso-8859-1?Q?NlzDkAm+8Ksziw5eSQzQZJybnUtO8iWjjzMYFNaerwPUj3AaYRjhjPuwV+?=
 =?iso-8859-1?Q?vA4oyE6nQOcxcCXO/tGv3MkATb46LYP24SobXldQp1eFrSLQb5/1VoVDpy?=
 =?iso-8859-1?Q?Co0tFBZH3f8bfNjNKz3DZFZk1m2N9wfPZfEROWRIS4XFVqUODq7H9b1Llq?=
 =?iso-8859-1?Q?H7Anl/w9V33zXDhJMXKXyBl/8mwLKI8RyJnJese9BSdhpLw4lGtMIRgiDJ?=
 =?iso-8859-1?Q?hfjxOpi7kk540qt9P0jBYhGUU7LNPoYj899t2T+Bv3/nJ26XebTSSRMs2v?=
 =?iso-8859-1?Q?+2GnB0yAGaj5/S8jTeRYp6cBItO+78Z4Zp6qUHjyqXOf+82k91qUek5I5J?=
 =?iso-8859-1?Q?5Ici05M1lME4eN0NZveFSyvZRCY8/4nf+6aXx9/EN3Q4NDfTcnjqsKxndi?=
 =?iso-8859-1?Q?QBJHZ1z8drnsEFfUK08dxZPcgBGY6/2VCwv1Ckf/yIZs1z86LP+LkUtlXh?=
 =?iso-8859-1?Q?+tJvVdbSX2iD9DnxrDiBi492wpHp7HXc4U5CuVljFAfM8UZ+PAnX7d7rQv?=
 =?iso-8859-1?Q?IeSOkAuPetDaiuKmzWcU5k8hBSdESJ/uz1MOxrR8VkkacrV3a/MSgBM10i?=
 =?iso-8859-1?Q?woJuWTKfknrd5olAafOpXuDZb6kZ0m7NIDlTo8uaEDycfWMYK24SN9JfzV?=
 =?iso-8859-1?Q?I7ivf0vuz8Cp3Frvnb2RgiOhdU5Obx1tJpk3MFgBpqbi7qJ4tkcpRM4CKs?=
 =?iso-8859-1?Q?dHdsjwUhOEcdGSfBZ5Ss9+wH/uFerkwjU6x0eXaQQDn15OnpKMGUkYOB0w?=
 =?iso-8859-1?Q?gUmXN0lIC74Wi4ySTKCKgHeXUrWW3nha5wwNLKBMzBfle3zJdQrpRS30cF?=
 =?iso-8859-1?Q?+rZTlZwxtGt4Wu6OVeHvyGo3tyMzTu/IZVWL+LAmDDyUXfBrXGsVvsqfZI?=
 =?iso-8859-1?Q?l0wciptecjdNJPapErt+VqOvVn1AVDa4WK5H16umewHBEf1IDp60iEb+3R?=
 =?iso-8859-1?Q?iJtstyyH/YMRind5qn53KEJeo15ukms6F99/qI9h7YJ5j+eHn/qqY2meSg?=
 =?iso-8859-1?Q?SDJ/OMw/Eb3nnnSgY36h3xNfNisjuk4O4Xes6QFdxgMJli2PtcT5SQ6JbS?=
 =?iso-8859-1?Q?ldPyZpmNBwxvXToGDmUor3KnfsOmEd4iqaDqcbeov49Hus+1DcDfFnZlKy?=
 =?iso-8859-1?Q?bmkuYfTXkAfiYPdl801QaYDmeF4nV92k0uwZb//erhXVx+ZR8YkM0kMopV?=
 =?iso-8859-1?Q?UHFFEmnwjJlLbjozk/baTpy+nDY7rZA1haoF/NZ/bCVS16NXyYSnIBn1pE?=
 =?iso-8859-1?Q?wOozOPFQmw=3D=3D?=
X-Exchange-RoutingPolicyChecked: C5o7tFDPpAZpvxKWzOO0Io/AUWhAewD1p418qGZ7jtLKygzNj2tWxrmTnqpzwxxVq7UJKslFA4DTrfQRAQNe+covlGmh49RsNzg8nMsjGoo3puY61cpuVtFBUu1qQHf0ogfQiXQJn94MEB2PUw3W6Ghl9iLHTkajyl6NAVg7buYoYh8KYaqsqlPqpDZbSrzhipcZPjy5KDRyJh3PBaQ+6CMxm1DqrDSKPQmeUvW6PeCL/219hBo11zmGsv2s4LeE/vZsQE0F9A6ymUoR9cN6qtbfNk7209Mw9ktmGjvNFLLkhoxVd+wdHREeWiDQIHHL2xO9P60yJMSqPvd8BzIqhA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0fae46-62a4-4c4f-047c-08df468b130e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 22:18:44.5573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VujSb0NPJn8uilWRD8ioKM6/kVh71TRS7Apdb07sEsCniTogWumksNiJgLYImRZRlm22H8rnWMx2C33DxLKLFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6131
X-OriginatorOrg: intel.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dave, Sima,

Here is this week's PR for drm-xe-fixes. Things have settled down, and
it's pretty much all small patches fixing a few lines here and there,
aside from Thomas's dma-buf accounting fix in the exporter.

Matt 

drm-xe-fixes-2026-11-19-1:
Driver Changes:
- hwmon error handling fixes (Dnyaneshwar, Karthik)
- Treat CT-disabled TLB invalidation as cancelled (Zongyao)
- Validate BOs on export to charge the exporter (Thomas)
- Always free requested IRQs on uninstall (Arvind)
- Reset TLB invalidation state in submit fini (Piotr)
- Use ordered clock reads for engine cycles cpu_delta (Sanjay)
- Treat non-fatal PCIe errors as recovered (Riana)
The following changes since commit aebb7274476403040d582c61478df8f4a7bf9cd3:

  Linux 7.4-rc3 (2026-11-15 14:30:11 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-11-19-1

for you to fetch changes up to 58417a6534dd3c190203a50541aa34b4a98bf275:

  drm/xe/hwmon: Propagate all hardware read errors (2026-11-18 20:17:28 -0800)

----------------------------------------------------------------
Driver Changes:
- hwmon error handling fixes (Dnyaneshwar, Karthik)
- Treat CT-disabled TLB invalidation as cancelled (Zongyao)
- Validate BOs on export to charge the exporter (Thomas)
- Always free requested IRQs on uninstall (Arvind)
- Reset TLB invalidation state in submit fini (Piotr)
- Use ordered clock reads for engine cycles cpu_delta (Sanjay)
- Treat non-fatal PCIe errors as recovered (Riana)

----------------------------------------------------------------
Arvind Yadav (1):
      drm/xe/irq: Always free requested IRQs on uninstall

Dnyaneshwar Bhadane (2):
      drm/xe/log: Add VRAM, PAT, and HWMON DRIVER_HARDWARE components
      drm/xe/hwmon: Report errors using structured xe_log API

Karthik Poosa (1):
      drm/xe/hwmon: Propagate all hardware read errors

Piotr Piórkowski (1):
      drm/xe/guc: Reset TLB invalidation state in submit fini

Riana Tauro (1):
      drm/xe/ras: Treat non-fatal PCIe errors as recovered

Sanjay Yadav (1):
      drm/xe/query: Use ordered clock reads for engine cycles cpu_delta

Thomas Hellström (1):
      drm/xe/dma-buf: Validate BOs on export to charge the exporter

Zongyao Bai (1):
      drm/xe/guc: Treat CT-disabled TLB invalidation as cancelled

 drivers/gpu/drm/xe/abi/xe_log_abi.h   |  3 ++
 drivers/gpu/drm/xe/xe_dma_buf.c       | 82 ++++++++++++++++++-----------------
 drivers/gpu/drm/xe/xe_guc_submit.c    |  2 +
 drivers/gpu/drm/xe/xe_guc_tlb_inval.c | 14 +++++-
 drivers/gpu/drm/xe/xe_hwmon.c         | 62 ++++++++++++++++----------
 drivers/gpu/drm/xe/xe_irq.c           |  6 +--
 drivers/gpu/drm/xe/xe_query.c         |  6 +--
 drivers/gpu/drm/xe/xe_ras.c           |  2 +-
 8 files changed, 103 insertions(+), 74 deletions(-)
